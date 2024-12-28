import 'package:focus_server/src/custom_scope.dart';
import 'package:focus_server/src/extensions/session_extension.dart';
import 'package:focus_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Handles work related to [Task]s.
class TaskEndpoint extends Endpoint {
  @override
  Set<Scope> get requiredScopes => {CustomScope.task};

  /// Get all tasks for a [User].
  Future<List<Task>> getTasks(Session session, int page) async {
    return session.db.transaction((Transaction transaction) async {
      try {
        final user = await session.parseUserFromFocusSession(transaction);
        return await Task.db.find(
          session,
          where: (TaskTable table) => table.userId.equals(user.id!),
          orderBy: (TaskTable table) => table.createdAt,
          limit: 25,
          offset: page * 25,
          transaction: transaction,
        );
      } on InvalidTokenException catch (_) {
        rethrow;
      } catch (error, stackTrace) {
        session.log(
          'error in getTasks',
          level: LogLevel.error,
          exception: error,
          stackTrace: stackTrace,
        );
        throw TaskFetchException(message: 'failed to fetch tasks');
      }
    });
  }

  /// Create a [Task].
  Future<Task> createTask(
    Session session, {
    required String title,
    String? desription,
    required List<AbilityExperienceValue> abilityExpValues,
  }) async {
    return session.db.transaction((Transaction transaction) async {
      try {
        final user = await session.parseUserFromFocusSession(transaction);
        final now = DateTime.timestamp();
        final task = Task(
          createdAt: now,
          lastModifiedAt: now,
          userId: user.id!,
          title: title,
          description: desription,
          abilityExpValues: abilityExpValues,
        );
        return await Task.db.insertRow(session, task, transaction: transaction);
      } on TaskCreationException catch (_) {
        rethrow;
      } catch (error, stackTrace) {
        session.log(
          'error in createTask',
          level: LogLevel.error,
          exception: error,
          stackTrace: stackTrace,
        );
        throw TaskCreationException(message: 'failed to create task.');
      }
    });
  }
}
