import 'package:focus_server/src/custom_scope.dart';
import 'package:focus_server/src/extensions/session_extension.dart';
import 'package:focus_server/src/extensions/user_ability_stats.dart';
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
        session.logError('error in getTasks', error, stackTrace);
        throw FetchException(message: 'failed to fetch tasks.');
      }
    });
  }

  /// Create a [Task].
  Future<Task> createTask(
    Session session, {
    required String title,
    String? description,
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
        );
        return await Task.db.insertRow(session, task, transaction: transaction);
      } catch (error, stackTrace) {
        session.logError('error in createTask', error, stackTrace);
        throw CreationException(message: 'failed to create task.');
      }
    });
  }

  /// Marks a [Task] as complete.
  Future<UserWithTask> completeTask(
    Session session,
    int taskId,
    UserAbilityStats abilityExpValues,
  ) async {
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
        task.completed = true;
        user.abilityStats = task.completed
            ? user.abilityStats + abilityExpValues.buffed(user.buffs).debuffed(user.debuffs)
            : user.abilityStats - abilityExpValues.buffed(user.buffs).debuffed(user.debuffs);
        task.lastModifiedAt = DateTime.timestamp();
        final updatedUser = await User.db.updateRow(session, user);
        final updatedTask = await Task.db.updateRow(session, task, transaction: transaction);
        return UserWithTask(user: updatedUser, task: updatedTask);
      } on NotFoundException catch (_) {
        rethrow;
      } catch (error, stackTrace) {
        session.logError('error in completeTask', error, stackTrace);
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
          ..description = description;
        return await Task.db.updateRow(session, task, transaction: transaction);
      } on NotFoundException catch (_) {
        rethrow;
      } catch (error, stackTrace) {
        session.logError('error in updateTask', error, stackTrace);
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
        session.logError('error in deleteTask', error, stackTrace);
        throw DeletionException(message: 'failed to delete task.');
      }
    });
  }

  /// Returns [TaskStats] for [User].
  Future<TaskStats> getTaskStats(Session session) async {
    return await session.db.transaction((Transaction transaction) async {
      try {
        final user = await session.parseUserFromFocusSession(transaction);
        final tasks = await Task.db.find(
          session,
          where: (TaskTable table) => table.userId.equals(user.id!),
          transaction: transaction,
        );
        var completedTally = 0;
        var incompleteTally = 0;
        var longestRunningTaskTime = Duration.zero;
        var shortestCompletionTaskTime = const Duration(days: 99999);
        Task? longestCompletedTask;
        Task? longestIncompleteTask;
        Task? shortestCompletedTask;
        final completionDurations = <Duration>[];
        final now = DateTime.timestamp();
        for (final task in tasks) {
          if (task.completed) {
            completedTally += 1;
            final completionTime = task.lastModifiedAt.difference(task.createdAt);
            if (completionTime > longestRunningTaskTime) {
              longestRunningTaskTime = completionTime;
              longestCompletedTask = task;
            }
            if (completionTime < shortestCompletionTaskTime) {
              shortestCompletionTaskTime = completionTime;
              shortestCompletedTask = task;
            }
            completionDurations.add(completionTime);
          } else {
            incompleteTally += 1;
            final runningTime = now.difference(task.createdAt);
            if (runningTime > longestRunningTaskTime) {
              longestRunningTaskTime = runningTime;
              longestIncompleteTask = task;
            }
          }
        }
        var averageInMilliseconds = 0;
        if (completedTally > 0) {
          final totalDuration = completionDurations.reduce((a, b) => a + b);
          averageInMilliseconds = totalDuration.inMilliseconds ~/ completedTally;
        }
        final averageCompletionTime = completedTally > 0 //
            ? Duration(milliseconds: averageInMilliseconds)
            : Duration.zero;
        return TaskStats(
          completedTally: completedTally,
          incompleteTally: incompleteTally,
          averageCompletionTime: averageCompletionTime,
          longestCompletionTime: longestRunningTaskTime,
          shortestCompletionTime: shortestCompletionTaskTime,
          longestRunningTaskTime: longestRunningTaskTime,
          longestCompletedTask: longestCompletedTask,
          longestIncompleteTask: longestIncompleteTask,
          shortestCompletedTask: shortestCompletedTask,
        );
      } catch (error, stackTrace) {
        session.logError('error in getTaskStats', error, stackTrace);
        throw FetchException(message: 'failed to fetch task stats.');
      }
    });
  }
}
