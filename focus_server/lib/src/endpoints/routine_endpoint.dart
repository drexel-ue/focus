import 'package:focus_server/src/custom_scope.dart';
import 'package:focus_server/src/extensions/session_extension.dart';
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
    required bool active,
    List<RoutineStep>? steps,
    List<RoutineSegment>? segments,
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
          active: active,
          steps: steps,
          segments: segments,
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
    required bool active,
    List<RoutineStep>? steps,
    List<RoutineSegment>? segments,
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
          active: active,
          steps: steps,
          segments: segments,
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
}
