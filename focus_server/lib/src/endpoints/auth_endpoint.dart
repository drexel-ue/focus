import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:focus_server/src/custom_scope.dart';
import 'package:focus_server/src/extensions/session_extension.dart';
import 'package:focus_server/src/future_calls/remove_user_buff_future_call.dart';
import 'package:focus_server/src/future_calls/remove_user_debuff_future_call.dart';
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
        user = await _checkForDiscipline(session, transaction, user);
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
    return await session.db.transaction((Transaction transaction) async {
      try {
        final jwt = JWT.verify(authToken.refreshToken, _secretKey);
        if (jwt.payload['parent_token'] == authToken.accessToken) {
          final userId = int.parse(jwt.subject!);
          var user = await User.db.findById(session, userId);
          if (user == null) {
            throw NotFoundException(message: 'missing User');
          }
          user = await _checkForDiscipline(session, transaction, user);
          final authSession = AuthSession(
            token: _generateAuthToken(session, user),
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
    });
  }

  Future<User> _checkForDiscipline(Session session, Transaction transaction, User user) async {
    final now = DateTime.timestamp();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    if (user.createdAt!.isAfter(sevenDaysAgo)) {
      return user;
    }
    final records = await RoutineRecord.db.find(
      session,
      transaction: transaction,
      where: (table) =>
          table.userId.equals(user.id!) &
          table.status.equals(RoutineRecordStatus.completed) &
          table.lastModifiedAt.between(sevenDaysAgo, now),
    );
    final tasks = await Task.db.find(
      session,
      transaction: transaction,
      where: (table) =>
          table.userId.equals(user.id!) &
          table.completed.equals(true) &
          table.lastModifiedAt.between(sevenDaysAgo, now),
    );
    var disciplined = true;
    DateTime dayChecking = now.subtract(const Duration(days: 1));
    while (dayChecking.isAfter(sevenDaysAgo)) {
      final routinesCompletedTally =
          records.where((record) => record.createdAt.isSameDayAs(dayChecking)).length;
      if (routinesCompletedTally == 0) {
        disciplined = false;
        break;
      }
      final tasksCompletedTally = tasks
          .where((task) => task.completed && task.lastModifiedAt.isSameDayAs(dayChecking))
          .length;
      if (tasksCompletedTally == 0) {
        disciplined = false;
        break;
      }
      dayChecking = dayChecking.subtract(const Duration(days: 1));
    }
    if (disciplined) {
      user.buffs = {...user.buffs, UserBuff.disciplined}.toList();
      await RemoveUserBuffFutureCall.schedule(session, transaction, user, UserBuff.disciplined);
    } else {
      user.debuffs = {...user.debuffs, UserDebuff.undisciplined}.toList();
      await RemoveUserDebuffFutureCall.schedule(
        session,
        transaction,
        user,
        UserDebuff.undisciplined,
      );
    }
    return await User.db.updateRow(session, user, transaction: transaction);
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

extension on DateTime {
  bool isSameDayAs(DateTime other) {
    final dayAfterOther = other.add(const Duration(days: 1));
    return isAfter(other) && isBefore(dayAfterOther);
  }
}
