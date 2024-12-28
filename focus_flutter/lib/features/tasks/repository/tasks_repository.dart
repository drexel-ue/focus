import 'dart:async';

import 'package:clerk_flutter/logging.dart';
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
      state = AsyncData(
        TaskState(
          tasks: [...currentState.requireValue.tasks, ...tasks!],
          page: currentState.requireValue.page + (tasks.length == 25 ? 1 : 0),
        ),
      );
    } catch (error, stackTrace) {
      logSevere('error in loadTasks', error, stackTrace);
      state = AsyncError<TaskState>(error, stackTrace).copyWithPrevious(currentState);
      homeRepo.showNegativeSnack('Failed to load tasks');
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
          desription: description,
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
      homeRepo.showNegativeSnack('Failed to create task: $title');
    }
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
      homeRepo.showNegativeSnack('Failed to load tasks');
      return const TaskState();
    }
  }
}
