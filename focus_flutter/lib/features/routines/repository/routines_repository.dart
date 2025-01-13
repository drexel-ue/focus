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

  /// Updates a [Routine].
  Future<void> updateRoutine({
    required int routineId,
    required String title,
    required List<UserBuff> buffs,
    required List<UserDebuff> debuffs,
    required List<RoutineStep> steps,
  }) async {
    final currentState = state;
    try {
      state = const AsyncLoading<RoutinesState>().copyWithPrevious(currentState);
      homeRepo.showSnack('Updating routine: $title...');
      final routine = await refreshIfNeeded((api) async {
        return await api.routine.updateRoutine(
          routineId: routineId,
          title: title,
          steps: steps,
          buffs: buffs,
          debuffs: debuffs,
        );
      });
      final index =
          currentState.requireValue.routines.indexWhere((element) => element.id == routineId);
      final routines = currentState.requireValue.routines;
      routines[index] = routine!;
      state = AsyncData(currentState.requireValue.copyWith(routines: routines));
      homeRepo.showPositiveSnack('Updated routine: ${routine.title}');
    } catch (error, stackTrace) {
      logSevere('error in updateRoutine', error, stackTrace);
      state = AsyncError<RoutinesState>(error, stackTrace).copyWithPrevious(currentState);
      homeRepo.showNegativeSnack('Failed to update routine: $title. Tap to retry.', () async {
        await updateRoutine(
          routineId: routineId,
          title: title,
          buffs: buffs,
          debuffs: debuffs,
          steps: steps,
        );
      });
    }
  }

  /// Deletes a [Routine].
  Future<void> deleteRoutine(int routineId) async {
    final currentState = state;
    try {
      state = const AsyncLoading<RoutinesState>().copyWithPrevious(currentState);
      final routine =
          await refreshIfNeeded((api) async => await api.routine.deleteRoutine(routineId));
      final routines = currentState.requireValue.routines
        ..removeWhere((element) => element.id == routineId);
      state = AsyncData(currentState.requireValue.copyWith(routines: routines));
      homeRepo.showPositiveSnack('Deleted routine: ${routine!.title}');
    } catch (error, stackTrace) {
      logSevere('error in deleteRoutine', error, stackTrace);
      state = AsyncError<RoutinesState>(error, stackTrace).copyWithPrevious(currentState);
      homeRepo.showNegativeSnack('Failed to delete routine. Tap to retry.', () async {
        await deleteRoutine(routineId);
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
