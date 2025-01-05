import 'package:focus_server/src/custom_scope.dart';
import 'package:focus_server/src/extensions/session_extension.dart';
import 'package:focus_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Handles work related to [Task]s.
class TaskEndpoint extends Endpoint {
  @override
  Set<Scope> get requiredScopes => {CustomScope.task};

  /// Get tasks for a [User].
  Future<List<Task>> getTasks(Session session, int page) async {
    return session.db.transaction((Transaction transaction) async {
      try {
        final user = await session.parseUserFromFocusSession(transaction);
        return await Task.db.find(
          session,
          where: (TaskTable table) => table.userId.equals(user.id!),
          orderBy: (TaskTable table) => table.createdAt,
          orderDescending: true,
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
        throw FetchException(message: 'failed to fetch tasks.');
      }
    });
  }

  /// Create a [Task].
  Future<Task> createTask(
    Session session, {
    required String title,
    String? description,
    required UserAbilityStats abilityExpValues,
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
          description: description,
          abilityExpValues: abilityExpValues,
        );
        return await Task.db.insertRow(session, task, transaction: transaction);
      } catch (error, stackTrace) {
        session.log(
          'error in createTask',
          level: LogLevel.error,
          exception: error,
          stackTrace: stackTrace,
        );
        throw CreationException(message: 'failed to create task.');
      }
    });
  }

  /// Toggles the completion state of a [Task].
  Future<UserWithTask> toggleTaskComplete(Session session, int taskId) async {
    return await session.db.transaction((Transaction transaction) async {
      try {
        final user = await session.parseUserFromFocusSession(transaction);
        final task = await session.findUserTask(
          taskId: taskId,
          userId: user.id!,
          transaction: transaction,
        );
        if (task == null) {
          throw NotFoundException(message: 'task not found');
        }
        task.completed = !task.completed;
        user.abilityStats = task.completed
            ? _addStats(user.abilityStats, task.abilityExpValues)
            : _substractStats(user.abilityStats, task.abilityExpValues);
        final updatedUser = await User.db.updateRow(session, user);
        final updatedTask = await Task.db.updateRow(session, task, transaction: transaction);
        return UserWithTask(user: updatedUser, task: updatedTask);
      } on NotFoundException catch (_) {
        rethrow;
      } catch (error, stackTrace) {
        session.log(
          'error in toggleTaskComplete',
          level: LogLevel.error,
          exception: error,
          stackTrace: stackTrace,
        );
        throw UpdateException(message: 'failed to update task.');
      }
    });
  }

  /// Update a [Task].
  Future<Task> updateTask(
    Session session, {
    required int taskId,
    required String title,
    String? description,
    required UserAbilityStats abilityExpValues,
  }) async {
    return session.db.transaction((Transaction transaction) async {
      try {
        final user = await session.parseUserFromFocusSession(transaction);
        final task = await session.findUserTask(
          taskId: taskId,
          userId: user.id!,
          transaction: transaction,
        );
        if (task == null) {
          throw NotFoundException(message: 'task not found.');
        }
        task
          ..lastModifiedAt = DateTime.timestamp()
          ..title = title
          ..description = description
          ..abilityExpValues = abilityExpValues;
        return await Task.db.updateRow(session, task, transaction: transaction);
      } on NotFoundException catch (_) {
        rethrow;
      } catch (error, stackTrace) {
        session.log(
          'error in updateTask',
          level: LogLevel.error,
          exception: error,
          stackTrace: stackTrace,
        );
        throw CreationException(message: 'failed to update task.');
      }
    });
  }

  /// Deletes a [Task].
  Future<Task> deleteTask(Session session, int taskId) async {
    return session.db.transaction((Transaction transaction) async {
      try {
        final user = await session.parseUserFromFocusSession(transaction);
        final task = await session.findUserTask(
          taskId: taskId,
          userId: user.id!,
          transaction: transaction,
        );
        if (task == null) {
          throw NotFoundException(message: 'task not found.');
        }
        return await Task.db.deleteRow(session, task, transaction: transaction);
      } catch (error, stackTrace) {
        session.log(
          'error in deleteTask',
          level: LogLevel.error,
          exception: error,
          stackTrace: stackTrace,
        );
        throw DeletionException(message: 'failed to delete task.');
      }
    });
  }

  UserAbilityStats _addStats(UserAbilityStats a, UserAbilityStats b) {
    return UserAbilityStats(
      strengthExp: a.strengthExp + b.strengthExp,
      vitalityExp: a.vitalityExp + b.vitalityExp,
      agilityExp: a.agilityExp + b.agilityExp,
      intelligenceExp: a.intelligenceExp + b.intelligenceExp,
      perceptionExp: a.perceptionExp + b.perceptionExp,
    );
  }

  UserAbilityStats _substractStats(UserAbilityStats a, UserAbilityStats b) {
    return UserAbilityStats(
      strengthExp: a.strengthExp - b.strengthExp,
      vitalityExp: a.vitalityExp - b.vitalityExp,
      agilityExp: a.agilityExp - b.agilityExp,
      intelligenceExp: a.intelligenceExp - b.intelligenceExp,
      perceptionExp: a.perceptionExp - b.perceptionExp,
    );
  }
}
