import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:focus_server/src/custom_scope.dart';
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
        final parsedUser = await _parseUserFromSession(session);
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

  Future<User> _parseUserFromSession(Session session) async {
    final clerkPem = await File(session.passwords['clerkJwtPem'] as String).readAsString();
    final key = RSAPublicKey(clerkPem);
    final jwt = JWT.verify(session.authenticationKey!, key);
    return User(
      clerkUserId: jwt.payload['clerk_id'],
      firstName: jwt.payload['first_name'],
      lastName: jwt.payload['last_name'],
      profileImageUrl: jwt.payload['image_url'],
    );
  }

  /// Generates an [AuthToken] containing an access token and a refresh token.
  /// The refresh token is keyed to the access token.
  AuthToken _generateAuthToken(Session session, User user) {
    const issuer = 'focus_server';
    final scopes = <CustomScope>{CustomScope.home};
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
