import 'dart:async';

import 'package:clerk_flutter/logging.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/api/api_client.dart';
import 'package:focus_flutter/features/home/repository/home_repository.dart';
import 'package:focus_flutter/features/tasks/repository/task_state.dart';

export 'package:focus_flutter/features/tasks/repository/task_state.dart';

/// Proivdes access to [TasksRepository].
final taskRepositoryProvider = AsyncNotifierProvider<TasksRepository, TaskState>(() {
  return TasksRepository();
});

/// Manages [Task]s.
class TasksRepository extends AsyncNotifier<TaskState> with ApiClientRef, Logging, HomeRepoRef {
  /// Loads tasks into memory with pagination.
  Future<void> loadTasks() async {
    final currentState = state;
    try {
      state = const AsyncLoading<TaskState>().copyWithPrevious(currentState);
      final tasks = await refreshIfNeeded((api) async {
        return await api.task.getTasks(currentState.requireValue.page);
      });
      final newTasks = <Task>[];
      for (final task in currentState.requireValue.tasks) {
        if (newTasks.none((element) => element.id == task.id)) {
          newTasks.add(task);
        }
      }
      for (final task in tasks!) {
        if (newTasks.none((element) => element.id == task.id)) {
          newTasks.add(task);
        }
      }
      state = AsyncData(
        TaskState(
          tasks: newTasks,
          page: currentState.requireValue.page + (tasks.length == 25 ? 1 : 0),
        ),
      );
    } catch (error, stackTrace) {
      logSevere('error in loadTasks', error, stackTrace);
      state = AsyncError<TaskState>(error, stackTrace).copyWithPrevious(currentState);
      homeRepo.showNegativeSnack('Failed to load tasks. Tap to retry.', _retryLoad);
    }
  }

  /// Creates a new [Task].
  Future<void> createTask({
    required String title,
    String? description,
    required List<AbilityExperienceValue> abilityExpValues,
  }) async {
    final currentState = state;
    try {
      state = const AsyncLoading<TaskState>().copyWithPrevious(currentState);
      homeRepo.showSnack('Creating task: $title...');
      final task = await refreshIfNeeded((api) async {
        return await api.task.createTask(
          title: title,
          description: description,
          abilityExpValues: abilityExpValues,
        );
      });
      state = AsyncData(
        currentState.requireValue.copyWith(
          tasks: [task!, ...currentState.requireValue.tasks],
        ),
      );
      homeRepo.showPositiveSnack('Created task: $title');
    } catch (error, stackTrace) {
      logSevere('error in createTask', error, stackTrace);
      state = AsyncError<TaskState>(error, stackTrace).copyWithPrevious(currentState);
      homeRepo.showNegativeSnack('Failed to create task: $title. Tap to retry.', () async {
        await createTask(
          title: title,
          description: description,
          abilityExpValues: abilityExpValues,
        );
      });
    }
  }

  /// Toggles the complete status of a [Task].
  Future<void> toggleTaskComplete(int taskId) async {
    final currentState = state;
    try {
      state = const AsyncLoading<TaskState>().copyWithPrevious(currentState);
      final task = await refreshIfNeeded((api) async => await api.task.toggleTaskComplete(taskId));
      final index = currentState.requireValue.tasks.indexWhere((element) => element.id == taskId);
      final tasks = currentState.requireValue.tasks;
      tasks[index] = task!;
      state = AsyncData(currentState.requireValue.copyWith(tasks: tasks));
      homeRepo.showPositiveSnack('Updated task: ${task.title}');
    } catch (error, stackTrace) {
      logSevere('error in toggleTaskComplete', error, stackTrace);
      state = AsyncError<TaskState>(error, stackTrace).copyWithPrevious(currentState);
      homeRepo.showNegativeSnack('Failed to update task. Tap to retry.', () async {
        await toggleTaskComplete(taskId);
      });
    }
  }

  /// Updates a [Task].
  Future<void> updateTask({
    required int taskId,
    required String title,
    String? description,
    required List<AbilityExperienceValue> abilityExpValues,
  }) async {
    final currentState = state;
    try {
      state = const AsyncLoading<TaskState>().copyWithPrevious(currentState);
      homeRepo.showSnack('Updating task: $title...');
      final task = await refreshIfNeeded((api) async {
        return await api.task.updateTask(
          taskId: taskId,
          title: title,
          description: description,
          abilityExpValues: abilityExpValues,
        );
      });
      final index = currentState.requireValue.tasks.indexWhere((element) => element.id == taskId);
      final tasks = currentState.requireValue.tasks;
      tasks[index] = task!;
      state = AsyncData(currentState.requireValue.copyWith(tasks: tasks));
      homeRepo.showPositiveSnack('Updated task: ${task.title}');
    } catch (error, stackTrace) {
      logSevere('error in createTask', error, stackTrace);
      state = AsyncError<TaskState>(error, stackTrace).copyWithPrevious(currentState);
      homeRepo.showNegativeSnack('Failed to update task: $title. Tap to retry.', () async {
        await createTask(
          title: title,
          description: description,
          abilityExpValues: abilityExpValues,
        );
      });
    }
  }

  /// Deletes a [Task].
  Future<void> deleteTask(int taskId) async {
    final currentState = state;
    try {
      state = const AsyncLoading<TaskState>().copyWithPrevious(currentState);
      final task = await refreshIfNeeded((api) async => await api.task.deleteTask(taskId));
      final tasks = currentState.requireValue.tasks..removeWhere((element) => element.id == taskId);
      state = AsyncData(currentState.requireValue.copyWith(tasks: tasks));
      homeRepo.showPositiveSnack('Deleted task: ${task!.title}');
    } catch (error, stackTrace) {
      logSevere('error in deleteTask', error, stackTrace);
      state = AsyncError<TaskState>(error, stackTrace).copyWithPrevious(currentState);
      homeRepo.showNegativeSnack('Failed to delete task. Tap to retry.', () async {
        await deleteTask(taskId);
      });
    }
  }

  Future<void> _retryLoad() async {
    homeRepo.showSnack('Attempting to load tasks');
    await loadTasks();
  }

  @override
  Future<TaskState> build() async {
    try {
      final tasks = await refreshIfNeeded((api) async {
        return await api.task.getTasks(0);
      });
      return TaskState(
        tasks: tasks!,
        page: tasks.length == 25 ? 1 : 0,
      );
    } catch (error, stackTrace) {
      logSevere('error in build', error, stackTrace);
      homeRepo.showNegativeSnack('Failed to load tasks. Tap to retry.', _retryLoad);
      return const TaskState();
    }
  }
}
