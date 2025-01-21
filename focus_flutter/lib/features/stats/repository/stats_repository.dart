import 'package:clerk_flutter/logging.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/api/api_client.dart';
import 'package:focus_flutter/features/home/repository/home_repository.dart';
import 'package:focus_flutter/features/stats/repository/stats_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'package:focus_flutter/features/stats/repository/stats_state.dart';

/// Provides access to the [StatsRepository].
final statsRepositoryProvider = AsyncNotifierProvider<StatsRepository, StatsState>(() {
  return StatsRepository();
});

/// Manages [TaskStats].
class StatsRepository extends AsyncNotifier<StatsState> with Logging, ApiClientRef, HomeRepoRef {
  /// Loads [TaskStats] into memory.
  void loadTaskStats() async {
    try {
      homeRepo.showSnack('Attempting to load task stats');
      state = AsyncData((state.value ?? const StatsState()).copyWith(loadingTaskStats: true));
      final stats = await refreshIfNeeded((api) async => await api.task.getTaskStats());
      state = AsyncData(
        state.requireValue.copyWith(
          taskStats: stats,
          loadingTaskStats: false,
        ),
      );
      homeRepo.showPositiveSnack('Task stats loaded!');
    } catch (error, stackTrace) {
      logSevere('error in loadTaskStats', error, stackTrace);
      state = AsyncError<StatsState>(error, stackTrace)
          .copyWithPrevious(AsyncData((state.value ?? const StatsState())));
      homeRepo.showNegativeSnack('Failed to load task stats. Tap to retry.', loadTaskStats);
    }
  }

  /// Loads [RoutineStats] into memory.
  void loadRoutineStats() async {
    try {
      homeRepo.showSnack('Attempting to load routine stats');
      state = AsyncData(state.requireValue.copyWith(loadingRoutineStats: true));
      final stats = await refreshIfNeeded((api) async => await api.routine.getRoutineStats());
      state = AsyncData(state.requireValue.copyWith(routineStats: stats));
      homeRepo.showPositiveSnack('Routine stats loaded!');
    } catch (error, stackTrace) {
      logSevere('error in loadRoutineStats', error, stackTrace);
      state =
          AsyncError<StatsState>(error, stackTrace).copyWithPrevious(AsyncData(state.requireValue));
      homeRepo.showNegativeSnack(
        'Failed to load routine stats. Tap to retry.',
        loadRoutineStats,
      );
    }
  }

  @override
  FutureOr<StatsState> build() async => const StatsState();
}
