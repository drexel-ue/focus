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
  /// Loads [TaskStats] into memory with pagination.
  Future<void> loadTaskStats() async {
    final currentState = state.value ?? const StatsState();
    try {
      state = AsyncData(currentState.copyWith(loadingTaskStats: true));
      final stats = await refreshIfNeeded((api) async => await api.task.getTaskStats());
      state = AsyncData(
        currentState.copyWith(
          taskStats: stats,
          loadingTaskStats: false,
        ),
      );
    } catch (error, stackTrace) {
      logSevere('error in loadTaskStats', error, stackTrace);
      state = AsyncError<StatsState>(error, stackTrace).copyWithPrevious(AsyncData(currentState));
      homeRepo.showNegativeSnack('Failed to load task stats. Tap to retry.', _retryLoad);
    }
  }

  Future<void> _retryLoad() async {
    homeRepo.showSnack('Attempting to load task stats');
    await loadTaskStats();
    homeRepo.showPositiveSnack('Task stats loaded!');
  }

  @override
  FutureOr<StatsState> build() async => const StatsState();
}
