import 'dart:async';

import 'package:clerk_flutter/logging.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/api/api_client.dart';
import 'package:focus_flutter/features/home/repository/home_repository.dart';
import 'package:focus_flutter/features/routines/repository/routines_state.dart';

/// Provides access to the [RoutinesRepository].
final routinesRepositoryProvider = AsyncNotifierProvider<RoutinesRepository, RoutinesState>(() {
  return RoutinesRepository();
});

/// Manages [Routine]s.
class RoutinesRepository extends AsyncNotifier<RoutinesState>
    with Logging, HomeRepoRef, ApiClientRef {
  /// Loads routines into memory with pagination.
  Future<void> loadRoutines() async {
    final currentState = state;
    try {
      final page = currentState.value?.page ?? 0;
      state = const AsyncLoading<RoutinesState>().copyWithPrevious(currentState);
      final routines = await refreshIfNeeded((api) async {
        return await api.routine.getRoutines(page);
      });
      final newRoutines = <Routine>[];
      for (final routine in currentState.value?.routines ?? const <Routine>[]) {
        if (newRoutines.none((element) => element.id == routine.id)) {
          newRoutines.add(routine);
        }
      }
      for (final routine in routines!) {
        if (newRoutines.none((element) => element.id == routine.id)) {
          newRoutines.add(routine);
        }
      }
      state = AsyncData(
        RoutinesState(
          routines: newRoutines,
          page: page + (routines.length == 25 ? 1 : 0),
          activeRoutine: currentState.value?.activeRoutine,
        ),
      );
    } catch (error, stackTrace) {
      logSevere('error in loadRoutines', error, stackTrace);
      state = AsyncError<RoutinesState>(error, stackTrace).copyWithPrevious(currentState);
      homeRepo.showNegativeSnack('Failed to load routines. Tap to retry.', _retryLoad);
    }
  }

  /// Creates a new [Routine].
  Future<void> createRoutine({
    required String title,
    required List<UserBuff> buffs,
    required List<UserDebuff> debuffs,
    required List<RoutineStep> steps,
  }) async {
    final currentState = state;
    try {
      state = const AsyncLoading<RoutinesState>().copyWithPrevious(currentState);
      homeRepo.showSnack('Creating routine: $title...');
      final routine = await refreshIfNeeded((api) async {
        return await api.routine.createRoutine(
          title: title,
          steps: steps,
          buffs: buffs,
          debuffs: debuffs,
        );
      });
      state = AsyncData(
        currentState.requireValue.copyWith(
          routines: [routine!, ...currentState.requireValue.routines],
        ),
      );
      homeRepo.showPositiveSnack('Created routine: $title');
    } catch (error, stackTrace) {
      logSevere('error in createRoutine', error, stackTrace);
      state = AsyncError<RoutinesState>(error, stackTrace).copyWithPrevious(currentState);
      homeRepo.showNegativeSnack('Failed to create routine: $title. Tap to retry.', () async {
        await createRoutine(
          title: title,
          steps: steps,
          buffs: buffs,
          debuffs: debuffs,
        );
      });
    }
  }

  /// Reset state.
  void logout() => state = const AsyncData(RoutinesState());

  Future<void> _retryLoad() async {
    homeRepo.showSnack('Attempting to load routines');
    await loadRoutines();
    homeRepo.showPositiveSnack('Routines loaded!');
  }

  @override
  FutureOr<RoutinesState> build() => const RoutinesState();
}
