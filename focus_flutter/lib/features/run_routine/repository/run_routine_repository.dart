import 'package:clerk_auth/clerk_auth.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/api/api_client.dart';
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
    with Logging, ApiClientRef, HomeRepoRef {
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

  @override
  FutureOr<RunRoutineRepositoryState> build() async {
    return const RunRoutineRepositoryState();
  }
}
