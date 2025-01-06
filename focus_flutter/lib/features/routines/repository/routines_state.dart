import 'package:flutter/foundation.dart';
import 'package:focus_client/focus_client.dart';

/// State of the [RoutineRepository].
@immutable
class RoutinesState {
  /// Constructs a const [RoutineState].
  const RoutinesState({
    this.routines = const [],
    this.page = 0,
    this.activeRoutine,
  });

  /// [Routine]s.
  final List<Routine> routines;

  /// Pagination key.
  final int page;

  /// Currently running [Routine].
  final Routine? activeRoutine;

  /// Creates a new [RoutinesState] while preserving data.
  RoutinesState copyWith({
    List<Routine>? routines,
    int? page,
    Routine? activeRoutine,
  }) {
    return RoutinesState(
      routines: routines ?? this.routines,
      page: page ?? this.page,
      activeRoutine: activeRoutine ?? this.activeRoutine,
    );
  }

  /// Returns current [RoutinesState] without [activeRoutine].
  RoutinesState get withoutActiveRoutine {
    return RoutinesState(
      routines: routines,
      page: page,
    );
  }
}
