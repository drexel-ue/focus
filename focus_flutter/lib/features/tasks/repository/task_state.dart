import 'package:flutter/foundation.dart';
import 'package:focus_client/focus_client.dart';

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
