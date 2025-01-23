import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/home/repository/home_repository.dart';
import 'package:focus_flutter/features/stats/repository/stats_repository.dart';
import 'package:focus_flutter/features/stats/view/routine_pie_chart.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/loading_cover.dart';

/// Displays [RoutineStats].
@immutable
class RoutineStatsTile extends ConsumerStatefulWidget {
  /// Constructs a const [RoutineStatsTile].
  const RoutineStatsTile({super.key});

  @override
  ConsumerState<RoutineStatsTile> createState() => _RoutineStatsTileState();
}

class _RoutineStatsTileState extends ConsumerState<RoutineStatsTile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(statsRepositoryProvider.notifier).loadRoutineStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(statsRepositoryProvider);
    final stats = state.value?.routineStats;
    final hasRoutines = stats?.mostRecentAborted != null ||
        stats?.mostRecentCompleted != null ||
        stats?.mostRecentTimedOut != null;
    return LoadingCover(
      loading: state.isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (stats != null && hasRoutines) ...[
            const Padding(
              padding: horizontalPadding16,
              child: RoutinePieChart(),
            ),
          ] else if (stats != null) ...[
            Center(
              child: SizedBox(
                width: 200.0,
                child: FocusButton(
                  onTap: () => ref.read(homeRepositoryProvider.notifier).tab = HomeTab.routines,
                  child: const Text('Go to [Routines]'),
                ),
              ),
            ),
          ] else
            Center(
              child: SizedBox(
                width: 200.0,
                child: FocusButton(
                  onTap: () => ref.read(statsRepositoryProvider.notifier).loadTaskStats(),
                  child: const Text('Load [Routine] stats'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
