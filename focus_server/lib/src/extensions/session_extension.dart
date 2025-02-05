import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:focus_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

///
extension SessionX on Session {
  /// Parses [User] from clerk auth token.
  Future<User> parseUserFromClerkSession() async {
    final clerkPem = await File(passwords['clerkJwtPem'] as String).readAsString();
    final key = RSAPublicKey(clerkPem);
    final jwt = JWT.verify(authenticationKey!, key);
    return User(
      clerkUserId: jwt.payload['clerk_id'],
      firstName: jwt.payload['first_name'],
      lastName: jwt.payload['last_name'],
      profileImageUrl: jwt.payload['image_url'],
      abilityStats: UserAbilityStats(
        strengthExp: 0,
        vitalityExp: 0,
        agilityExp: 0,
        intelligenceExp: 0,
        perceptionExp: 0,
      ),
      buffs: const [],
      debuffs: const [],
    );
  }

  /// Parses [User] from focus auth token.
  Future<User> parseUserFromFocusSession([Transaction? transaction]) async {
    final jwt = JWT.verify(authenticationKey!, secretKey);
    final user = await User.db.findById(this, int.parse(jwt.subject!), transaction: transaction);
    if (user == null) {
      throw InvalidTokenException();
    }
    return user;
  }

  /// Queries for [Task] matching [taskId] and [userId].
  Future<Task?> findUserTask({
    required int taskId,
    required int userId,
    Transaction? transaction,
  }) async {
    final task = await Task.db.findById(this, taskId, transaction: transaction);
    if (task == null || task.userId != userId) {
      return null;
    }
    return task;
  }

  /// Queries for [Routine] matching [routineId] and [userId].
  Future<Routine?> findUserRoutine({
    required int routineId,
    required int userId,
    Transaction? transaction,
  }) async {
    final routine = await Routine.db.findById(this, routineId, transaction: transaction);
    if (routine == null || routine.userId != userId) {
      return null;
    }
    return routine;
  }

  /// Logs an error.
  void logError(String message, [Object? error, StackTrace? stackTrace]) {
    log(message, level: LogLevel.error, exception: error, stackTrace: stackTrace);
  }

  /// Returns a [SecretKey] parsed from the environment.
  SecretKey get secretKey {
    final focusJwtSecret = passwords['focusJwtSecret'] as String;
    final encodedKey = sha256.convert(utf8.encode(focusJwtSecret)).toString();
    return SecretKey(encodedKey);
  }
}
