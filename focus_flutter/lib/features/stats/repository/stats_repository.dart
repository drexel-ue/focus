import 'dart:collection';

import 'package:clerk_flutter/logging.dart';
import 'package:flutter/foundation.dart';
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
  late final _queue = ValueNotifier(Queue<AsyncCallback>())..addListener(_handleQueue);

  void _enqueue(AsyncCallback callback) {
    _queue.value = Queue.from(_queue.value)..addLast(callback);
  }

  Future<void> _dequeue() async {
    final callback = _queue.value.removeFirst();
    await callback();
  }

  Future<void> _handleQueue() async {
    if (_queue.value.isNotEmpty) {
      await _dequeue();
      _handleQueue();
    }
  }

  /// Loads [TaskStats] into memory.
  void loadTaskStats() => _enqueue(_loadTaskStats);

  Future<void> _loadTaskStats() async {
    final currentState = state.value ?? const StatsState();
    try {
      homeRepo.showSnack('Attempting to load task stats');
      state = AsyncData(currentState.copyWith(loadingTaskStats: true));
      final stats = await refreshIfNeeded((api) async => await api.task.getTaskStats());
      state = AsyncData(
        currentState.copyWith(
          taskStats: stats,
          loadingTaskStats: false,
        ),
      );
      homeRepo.showPositiveSnack('Task stats loaded!');
    } catch (error, stackTrace) {
      logSevere('error in loadTaskStats', error, stackTrace);
      state = AsyncError<StatsState>(error, stackTrace).copyWithPrevious(AsyncData(currentState));
      homeRepo.showNegativeSnack('Failed to load task stats. Tap to retry.', loadTaskStats);
    }
  }

  /// Loads [RoutineStats] into memory.
  void loadRoutineStats() => _enqueue(_loadRoutineStats);

  Future<void> _loadRoutineStats() async {
    final currentState = state.value ?? const StatsState();
    try {
      homeRepo.showSnack('Attempting to load routine stats');
      state = AsyncData(currentState.copyWith(loadingRoutineStats: true));
      final stats = await refreshIfNeeded((api) async => await api.routine.getRoutineStats());
      state = AsyncData(currentState.copyWith(routineStats: stats));
      homeRepo.showPositiveSnack('Routine stats loaded!');
    } catch (error, stackTrace) {
      logSevere('error in loadRoutineStats', error, stackTrace);
      state = AsyncError<StatsState>(error, stackTrace).copyWithPrevious(AsyncData(currentState));
      homeRepo.showNegativeSnack(
        'Failed to load routine stats. Tap to retry.',
        loadRoutineStats,
      );
    }
  }

  @override
  FutureOr<StatsState> build() async => const StatsState();
}
