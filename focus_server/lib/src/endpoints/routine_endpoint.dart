import 'package:focus_server/src/custom_scope.dart';
import 'package:focus_server/src/extensions/session_extension.dart';
import 'package:focus_server/src/extensions/user_ability_stats.dart';
import 'package:focus_server/src/future_calls/remove_user_buff_future_call.dart';
import 'package:focus_server/src/future_calls/remove_user_debuff_future_call.dart';
import 'package:focus_server/src/future_calls/routine_completion_check_future_call.dart';
import 'package:focus_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Handles work related to [Routine]s.
class RoutineEndpoint extends Endpoint {
  @override
  Set<Scope> get requiredScopes => {CustomScope.routine};

  /// Get routines for a [User].
  Future<List<Routine>> getRoutines(Session session, int page) async {
    return session.db.transaction((Transaction transaction) async {
      try {
        final user = await session.parseUserFromFocusSession(transaction);
        return await Routine.db.find(
          session,
          where: (RoutineTable table) => table.userId.equals(user.id!),
          orderBy: (RoutineTable table) => table.createdAt,
          orderDescending: true,
          limit: 25,
          offset: page * 25,
          transaction: transaction,
        );
      } on InvalidTokenException catch (_) {
        rethrow;
      } catch (error, stackTrace) {
        session.log(
          'error in getRoutines',
          level: LogLevel.error,
          exception: error,
          stackTrace: stackTrace,
        );
        throw FetchException(message: 'failed to fetch routines.');
      }
    });
  }

  /// Creates and returns a new [Routine].
  Future<Routine> createRoutine(
    Session session, {
    required String title,
    required List<RoutineStep> steps,
    required List<UserBuff> buffs,
    required List<UserDebuff> debuffs,
  }) async {
    return await session.db.transaction((Transaction transaction) async {
      try {
        final user = await session.parseUserFromFocusSession(transaction);
        final now = DateTime.timestamp();
        final routine = Routine(
          createdAt: now,
          lastModifiedAt: now,
          userId: user.id!,
          title: title,
          steps: steps,
          buffs: buffs,
          debuffs: debuffs,
        );
        return await Routine.db.insertRow(session, routine, transaction: transaction);
      } catch (error, stackTrace) {
        session.log(
          'error in createRoutine',
          level: LogLevel.error,
          exception: error,
          stackTrace: stackTrace,
        );
        throw CreationException(message: 'failed to create routine.');
      }
    });
  }

  /// Updates an existing [Routine].
  Future<Routine> updateRoutine(
    Session session, {
    required int routineId,
    required String title,
    required List<RoutineStep> steps,
    required List<UserBuff> buffs,
    required List<UserDebuff> debuffs,
  }) async {
    return await session.db.transaction((Transaction transaction) async {
      try {
        final user = await session.parseUserFromFocusSession(transaction);
        final routine = await session.findUserRoutine(routineId: routineId, userId: user.id!);
        if (routine == null) {
          throw NotFoundException(message: 'routine not found.');
        }
        final now = DateTime.timestamp();
        routine
          ..lastModifiedAt = now
          ..title = title
          ..steps = steps
          ..buffs = buffs
          ..debuffs = debuffs;
        return await Routine.db.updateRow(session, routine, transaction: transaction);
      } catch (error, stackTrace) {
        session.log(
          'error in updateRoutine',
          level: LogLevel.error,
          exception: error,
          stackTrace: stackTrace,
        );
        throw CreationException(message: 'failed to update routine.');
      }
    });
  }

  /// Deletes a [Routine].
  Future<Routine> deleteRoutine(Session session, int routineId) async {
    return session.db.transaction((Transaction transaction) async {
      try {
        final user = await session.parseUserFromFocusSession(transaction);
        final routine = await session.findUserRoutine(
          routineId: routineId,
          userId: user.id!,
          transaction: transaction,
        );
        if (routine == null) {
          throw NotFoundException(message: 'routine not found.');
        }
        return await Routine.db.deleteRow(session, routine, transaction: transaction);
      } catch (error, stackTrace) {
        session.log(
          'error in deleteRoutine',
          level: LogLevel.error,
          exception: error,
          stackTrace: stackTrace,
        );
        throw DeletionException(message: 'failed to delete routine.');
      }
    });
  }

  /// Creates a [RoutineRecord] and registers a future call to be invoked in 24 hours to check for
  /// its completion.
  Future<RoutineRecord> startRoutine(Session session, int routineId) async {
    return await session.db.transaction((Transaction transaction) async {
      try {
        final user = await session.parseUserFromFocusSession(transaction);
        final routine = await Routine.db.findById(session, routineId);
        if (routine == null) {
          throw NotFoundException(message: 'missing Routine');
        }
        final now = DateTime.timestamp();
        var record = RoutineRecord(
          createdAt: now,
          lastModifiedAt: now,
          userId: user.id!,
          routineId: routineId,
        );
        record = await RoutineRecord.db.insertRow(session, record, transaction: transaction);
        await session.serverpod.futureCallAtTime(
          RoutineCompletionCheckFutureCall.callName,
          routine,
          now.add(const Duration(hours: 24)),
          identifier: '${record.id}',
        );
        return record;
      } catch (error, stackTrace) {
        session.log(
          'error in startRoutine',
          level: LogLevel.error,
          exception: error,
          stackTrace: stackTrace,
        );
        rethrow;
      }
    });
  }

  /// Marks a [RoutineRecord] as complete and cancels the future call tied to it.
  Future<UserWithRoutineRecord> completeRoutine(Session session, int routineId) async {
    return await session.db.transaction((Transaction transaction) async {
      try {
        return await _abortOrCompleteRoutine(
          session,
          transaction,
          routineId,
          RoutineRecordStatus.completed,
        );
      } catch (error, stackTrace) {
        session.log(
          'error in completeRoutine',
          level: LogLevel.error,
          exception: error,
          stackTrace: stackTrace,
        );
        rethrow;
      }
    });
  }

  /// Marks a [RoutineRecord] as aborted and cancels the future call tied to it.
  Future<UserWithRoutineRecord> abortRoutine(Session session, int routineId) async {
    return await session.db.transaction((Transaction transaction) async {
      try {
        return await _abortOrCompleteRoutine(
          session,
          transaction,
          routineId,
          RoutineRecordStatus.aborted,
        );
      } catch (error, stackTrace) {
        session.log(
          'error in completeRoutine',
          level: LogLevel.error,
          exception: error,
          stackTrace: stackTrace,
        );
        rethrow;
      }
    });
  }

  /// Checks for a running [Routine] and returns a [RoutineWithRecord] if found.
  Future<RoutineWithRecord?> findRunningRoutine(Session session) async {
    return await session.db.transaction((Transaction transaction) async {
      try {
        final user = await session.parseUserFromFocusSession(transaction);
        final record = await RoutineRecord.db.findFirstRow(
          session,
          where: (table) {
            return table.userId.equals(user.id!) & table.status.equals(RoutineRecordStatus.running);
          },
          transaction: transaction,
        );
        if (record == null) {
          return null;
        }
        final routine = await Routine.db.findById(
          session,
          record.routineId,
          transaction: transaction,
        );
        if (routine == null) {
          throw NotFoundException(message: 'missing Routine');
        }
        return RoutineWithRecord(routine: routine, record: record);
      } catch (error, stackTrace) {
        session.log(
          'error in findRunningRoutine',
          level: LogLevel.error,
          exception: error,
          stackTrace: stackTrace,
        );
        rethrow;
      }
    });
  }

  Future<UserWithRoutineRecord> _abortOrCompleteRoutine(
    Session session,
    Transaction transaction,
    int routineId,
    RoutineRecordStatus status,
  ) async {
    var user = await session.parseUserFromFocusSession(transaction);
    final routine = await Routine.db.findById(session, routineId);
    if (routine == null || routine.userId != user.id) {
      throw NotFoundException(message: 'missing Routine');
    }
    final records = await RoutineRecord.db.find(
      session,
      transaction: transaction,
      where: (table) => table.routineId.equals(routineId),
    );
    var record = records.firstWhere((el) => el.status == RoutineRecordStatus.running);
    record
      ..status = status
      ..lastModifiedAt = DateTime.timestamp();
    record = await RoutineRecord.db.updateRow(session, record, transaction: transaction);
    if (status == RoutineRecordStatus.completed) {
      for (final buff in routine.buffs) {
        await RemoveUserBuffFutureCall.schedule(session, transaction, user, buff);
        user.buffs = {...user.buffs, buff}.toList();
      }
      var stats = UserAbilityStats(
        strengthExp: 0,
        vitalityExp: 0,
        agilityExp: 0,
        intelligenceExp: 0,
        perceptionExp: 0,
      );
      for (final step in routine.steps) {
        stats = stats + step.abilityExpValues.buffed(user.buffs).debuffed(user.debuffs);
      }
      user.abilityStats = user.abilityStats + stats;
    } else {
      for (final debuff in routine.debuffs) {
        await RemoveUserDebuffFutureCall.schedule(session, transaction, user, debuff);
        user.debuffs = {...user.debuffs, debuff}.toList();
      }
    }
    user = await User.db.updateRow(session, user, transaction: transaction);
    await session.serverpod.cancelFutureCall('${record.id}');
    return UserWithRoutineRecord(user: user, record: record);
  }
}
