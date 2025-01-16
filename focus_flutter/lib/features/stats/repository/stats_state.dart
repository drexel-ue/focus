import 'package:flutter/foundation.dart';
import 'package:focus_client/focus_client.dart';

/// State of the [StatsRepository].
@immutable
class StatsState {
  /// Constructs a const [StatsState].
  const StatsState({
    this.taskStats,
    this.loadingTaskStats = false,
  });

  /// [TaskStats].
  final TaskStats? taskStats;

  /// Loading [TaskStats]?
  final bool loadingTaskStats;

  /// Creates a new [StatsState] while preserving data.
  StatsState copyWith({
    TaskStats? taskStats,
    bool? loadingTaskStats,
  }) {
    return StatsState(
      taskStats: taskStats ?? this.taskStats,
      loadingTaskStats: loadingTaskStats ?? this.loadingTaskStats,
    );
  }
}
