import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/home/repository/home_repository.dart';
import 'package:focus_flutter/features/stats/repository/stats_repository.dart';
import 'package:focus_flutter/features/stats/view/tasks_complete_incomplete_slider.dart';
import 'package:focus_flutter/features/stats/view/task_stats_expansion_tile.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/loading_cover.dart';

/// Displays [TaskStats].
@immutable
class TaskStatsTile extends ConsumerStatefulWidget {
  /// Constructs a const [TaskStatsTile].
  const TaskStatsTile({super.key});

  @override
  ConsumerState<TaskStatsTile> createState() => _TaskStatsTileState();
}

class _TaskStatsTileState extends ConsumerState<TaskStatsTile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(statsRepositoryProvider.notifier).loadTaskStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(statsRepositoryProvider);
    final stats = state.value?.taskStats;
    final hasTasks = (stats?.completedTally ?? 0) > 0 || (stats?.incompleteTally ?? 0) > 0;
    return LoadingCover(
      loading: state.isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (stats != null && hasTasks) ...[
            const Padding(
              padding: horizontalPadding16,
              child: TasksCompleteIncompleteSlider(),
            ),
            const TaskStatsExpansionTile(),
          ] else if (stats != null) ...[
            Center(
              child: SizedBox(
                width: 200.0,
                child: FocusButton(
                  onTap: () => ref.read(homeRepositoryProvider.notifier).tab = HomeTab.tasks,
                  child: const Text('Go to [Tasks]'),
                ),
              ),
            ),
          ] else
            Center(
              child: SizedBox(
                width: 200.0,
                child: FocusButton(
                  onTap: () => ref.read(statsRepositoryProvider.notifier).loadTaskStats(),
                  child: const Text('Load [Task] stats'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
