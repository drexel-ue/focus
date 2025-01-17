import 'package:flutter/material.dart';
import 'package:focus_client/focus_client.dart';

/// State of the [RunRoutineRepository].
@immutable
class RunRoutineRepositoryState {
  /// Constructs a const [RunRoutineRepositoryState].
  const RunRoutineRepositoryState({
    this.routine,
    this.record,
  });

  /// [Routine] to run.
  final Routine? routine;

  /// [RoutineRecord].
  final RoutineRecord? record;

  /// Creates a new [RunRoutineRepositoryState] while preserving data.
  RunRoutineRepositoryState copyWith({
    Routine? routine,
    RoutineRecord? record,
  }) {
    return RunRoutineRepositoryState(
      routine: routine ?? this.routine,
      record: record ?? this.record,
    );
  }

  /// Reset state.
  RunRoutineRepositoryState reset() {
    return const RunRoutineRepositoryState();
  }
}
