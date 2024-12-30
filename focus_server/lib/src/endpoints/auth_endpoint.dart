import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:focus_server/src/custom_scope.dart';
import 'package:focus_server/src/extensions/session_extension.dart';
import 'package:focus_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Handles [AuthSession] creation.
class AuthEndpoint extends Endpoint {
  @override
  Set<Scope> get requiredScopes => {CustomScope.auth};

  final _secretKey = SecretKey('secret');

  /// Creates a new [AuthSession].
  Future<AuthSession> authenticate(Session session) async {
    return session.db.transaction((Transaction transaction) async {
      try {
        final parsedUser = await session.parseUserFromClerkSession();
        User? user = await User.db.findFirstRow(
          session,
          where: (UserTable table) => table.clerkUserId.equals(parsedUser.clerkUserId),
          transaction: transaction,
        );
        final now = DateTime.timestamp();
        if (user == null) {
          user = parsedUser.copyWith(createdAt: now, lastModifiedAt: now);
          user = await User.db.insertRow(session, user, transaction: transaction);
        } else {
          user.lastModifiedAt = now;
          user = await User.db.updateRow(session, user, transaction: transaction);
        }
        return AuthSession(
          token: _generateAuthToken(session, user),
          user: user,
        );
      } catch (error, stackTrace) {
        session.log(
          'error in authenticate',
          level: LogLevel.error,
          exception: error,
          stackTrace: stackTrace,
        );
        throw AuthException(message: 'Unable to authenticate.');
      }
    });
  }

  /// Exchanges a refresh token for a fresh [AuthSession].
  Future<AuthSession> refresh(Session session, AuthToken authToken) async {
    try {
      final jwt = JWT.verify(authToken.refreshToken, _secretKey);
      if (jwt.payload['parent_token'] == authToken.accessToken) {
        final userId = int.parse(jwt.subject!);
        final user = await User.db.findById(session, userId);
        final authSession = AuthSession(
          token: _generateAuthToken(session, user!),
          user: user,
        );
        return authSession;
      }
      throw TokenMismatchException();
    } on TokenMismatchException catch (_) {
      rethrow;
    } catch (error, stackTrace) {
      session.log(
        'error in refresh',
        level: LogLevel.error,
        exception: error,
        stackTrace: stackTrace,
      );
      throw AuthException(message: 'failed to refresh token.');
    }
  }

  /// Generates an [AuthToken] containing an access token and a refresh token.
  /// The refresh token is keyed to the access token.
  AuthToken _generateAuthToken(Session session, User user) {
    const issuer = 'focus_server';
    final scopes = <CustomScope>{CustomScope.task, CustomScope.routine};
    final scopeString = scopes.map((CustomScope scope) => scope.name).join(', ');
    final accessTokenJwt = JWT(
      // FIXME(drexel-ue): what data should we bake into this token?
      {'scopes': scopeString},
      subject: user.id!.toString(),
      issuer: issuer,
    );
    final accessTokenString = accessTokenJwt.sign(
      _secretKey,
      // FIXME(drexel-ue): would it be better to set iat in payload using [Timestamp] and just calculate the expiry based on token type?
      expiresIn: const Duration(minutes: 15),
    );
    final refreshTokenJwt = JWT(
      {
        'parent_token': accessTokenString,
        'scopes': CustomScope.auth.name,
      },
      subject: user.id!.toString(),
      issuer: issuer,
    );
    final refreshTokenString = refreshTokenJwt.sign(
      _secretKey,
      expiresIn: const Duration(days: 30),
    );
    return AuthToken(
      accessToken: accessTokenString,
      refreshToken: refreshTokenString,
    );
  }
}
