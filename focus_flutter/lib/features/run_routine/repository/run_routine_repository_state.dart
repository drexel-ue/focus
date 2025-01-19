import 'package:flutter/material.dart';
import 'package:focus_client/focus_client.dart';

/// State of the [RunRoutineRepository].
@immutable
class RunRoutineRepositoryState {
  /// Constructs a const [RunRoutineRepositoryState].
  const RunRoutineRepositoryState({
    this.routine,
    this.currentStep,
    this.record,
    this.restDuration = Duration.zero,
  });

  /// [Routine] to run.
  final Routine? routine;

  /// Current step.
  final int? currentStep;

  /// [RoutineRecord].
  final RoutineRecord? record;

  /// Rest duration.
  final Duration restDuration;

  /// Creates a new [RunRoutineRepositoryState] while preserving data.
  RunRoutineRepositoryState copyWith({
    Routine? routine,
    int? currentStep,
    RoutineRecord? record,
    Duration? restDuration,
  }) {
    return RunRoutineRepositoryState(
      routine: routine ?? this.routine,
      currentStep: currentStep ?? this.currentStep,
      record: record ?? this.record,
      restDuration: restDuration ?? this.restDuration,
    );
  }

  /// Reset state.
  RunRoutineRepositoryState reset() {
    return const RunRoutineRepositoryState();
  }
}
