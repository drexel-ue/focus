import 'dart:async';

import 'package:clerk_flutter/logging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/api/api_client.dart';

/// Proivdes access to [TasksRepository].
final taskRepositoryProvider = AsyncNotifierProvider<TasksRepository, TaskState>(() {
  return TasksRepository()..loadTasks();
});

/// State of [TaskRepository].
@immutable
class TaskState {
  /// Constructs a new [TaskState].
  const TaskState({
    this.tasks = const [],
    this.page = 0,
  });

  /// [Task]s for the authenticated [User].
  final List<Task> tasks;

  /// Pagination key.
  final int page;

  /// Creates a new [TaskState] while preserving data.
  TaskState copyWith({
    List<Task>? tasks,
    int? page,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      page: page ?? this.page,
    );
  }
}

/// Manages [Task]s.
class TasksRepository extends AsyncNotifier<TaskState> with ApiClientRef, Logging {
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
          page: currentState.requireValue.page + 1,
        ),
      );
    } catch (error, stackTrace) {
      logSevere('error in loadTasks', error, stackTrace);
      state = AsyncError<TaskState>(error, stackTrace).copyWithPrevious(currentState);
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
      final task = await refreshIfNeeded((api) async {
        return await api.task.createTask(
          title: title,
          desription: description,
          abilityExpValues: abilityExpValues,
        );
      });
      state = AsyncData(
        TaskState(
          tasks: [task!, ...currentState.requireValue.tasks],
          page: currentState.requireValue.page + 1,
        ),
      );
    } catch (error, stackTrace) {
      logSevere('error in createTask', error, stackTrace);
      state = AsyncError<TaskState>(error, stackTrace).copyWithPrevious(currentState);
    }
  }

  @override
  FutureOr<TaskState> build() => const TaskState();
}
