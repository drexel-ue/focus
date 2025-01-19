import 'package:clerk_auth/clerk_auth.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/api/api_client.dart';
import 'package:focus_flutter/features/auth/repository/auth_repository.dart';
import 'package:focus_flutter/features/home/repository/home_repository.dart';
import 'package:focus_flutter/features/run_routine/repository/run_routine_repository_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'package:focus_flutter/features/run_routine/repository/run_routine_repository_state.dart';

/// Provides access to the [RunRoutineRepository].
final runRoutineRepositoryProvider =
    AsyncNotifierProvider<RunRoutineRepository, RunRoutineRepositoryState>(() {
  return RunRoutineRepository();
});

/// Manages the running of a [Routine].
class RunRoutineRepository extends AsyncNotifier<RunRoutineRepositoryState>
    with Logging, ApiClientRef, HomeRepoRef, AuthRepoRef {
  /// Runs a [Routine].
  Future<void> runRoutine(Routine routine) async {
    try {
      homeRepo.showSnack('Running routine: ${routine.title}...');
      state = const AsyncLoading<RunRoutineRepositoryState>().copyWithPrevious(state);
      final record = await refreshIfNeeded((api) async {
        return await api.routine.startRoutine(routine.id!);
      });
      state = AsyncData(state.requireValue.copyWith(routine: routine, record: record));
    } catch (error, stackTrace) {
      logSevere('error in runRoutine', error, stackTrace);
      state = AsyncError<RunRoutineRepositoryState>(error, stackTrace).copyWithPrevious(state);
    }
  }

  /// Checks for a running [Routine] and returns true if found.
  Future<bool> checkForRunningRoutine() async {
    try {
      homeRepo.showSnack('Checking for running routine...');
      state = const AsyncLoading<RunRoutineRepositoryState>().copyWithPrevious(state);
      final routineWithRecord = await refreshIfNeeded((api) async {
        return await api.routine.findRunningRoutine();
      });
      if (routineWithRecord == null) {
        state = const AsyncData(RunRoutineRepositoryState());
        homeRepo.showSnack('No running routine found.');
        return false;
      } else {
        state = AsyncData(
          state.requireValue.copyWith(
            routine: routineWithRecord.routine,
            record: routineWithRecord.record,
          ),
        );
        homeRepo.showPositiveSnack('Running routine found: ${routineWithRecord.routine.title}');
        return true;
      }
    } catch (error, stackTrace) {
      logSevere('error in findRunningRoutine', error, stackTrace);
      state = AsyncError<RunRoutineRepositoryState>(error, stackTrace).copyWithPrevious(state);
      return false;
    }
  }

  /// Aborts a [Routine].
  Future<void> abortRoutine() async {
    try {
      state = const AsyncLoading<RunRoutineRepositoryState>().copyWithPrevious(state);
      homeRepo.showNegativeSnack('Aborting routine...');
      state = const AsyncLoading<RunRoutineRepositoryState>().copyWithPrevious(state);
      final routine = state.requireValue.routine!;
      final userWithRoutineRecord = await refreshIfNeeded((api) async {
        return await api.routine.abortRoutine(routine.id!);
      });
      homeRepo.showNegativeSnack('Aborted routine: ${routine.title}');
      authRepo.user = userWithRoutineRecord!.user;
      state = const AsyncData(RunRoutineRepositoryState());
    } catch (error, stackTrace) {
      logSevere('error in abortRoutine', error, stackTrace);
      state = AsyncError<RunRoutineRepositoryState>(error, stackTrace).copyWithPrevious(state);
    }
  }

  set restDuration(Duration value) => state = AsyncData(
        state.requireValue.copyWith(restDuration: value),
      );

  set currentStep(int? value) => state = AsyncData(
        state.requireValue.copyWith(currentStep: value),
      );

  @override
  FutureOr<RunRoutineRepositoryState> build() async {
    return const RunRoutineRepositoryState();
  }
}
