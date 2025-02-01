import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/extensions/duration.dart';
import 'package:focus_flutter/features/stats/repository/stats_repository.dart';
import 'package:focus_flutter/features/tasks/view/task_form.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/focus_window.dart';

/// Displays [TaskStats].
@immutable
class TaskStatsExpansionTile extends ConsumerStatefulWidget {
  /// Constructs a const [TaskStatsExpansionTile].
  const TaskStatsExpansionTile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskStatsExpansionTileState();
}

class _TaskStatsExpansionTileState extends ConsumerState<TaskStatsExpansionTile> {
  bool _isExpanded = false;

  void _showTaskForm(BuildContext context, Task task) {
    FocusWindow.show(
      context,
      (BuildContext context, CloseWindow closeModal) {
        return TaskForm(task: task);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final stats = ref.watch(statsRepositoryProvider).requireValue.taskStats!;
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'more',
            textAlign: TextAlign.center,
            style: TextTheme.of(context).labelLarge,
          ),
          horizontalMargin4,
          Icon(
            _isExpanded //
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
          ),
        ],
      ),
      showTrailingIcon: false,
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      onExpansionChanged: (bool expanded) => setState(() => _isExpanded = expanded),
      children: [
        verticalMargin2,
        Padding(
          padding: horizontalPadding16,
          child: Row(
            children: [
              Expanded(
                child: FocusButton(
                  onTap: stats.shortestCompletedTask != null
                      ? () => _showTaskForm(context, stats.shortestCompletedTask!)
                      : null,
                  child: const Text('Quickest'),
                ),
              ),
              horizontalMargin16,
              Expanded(
                child: FocusButton(
                  onTap: stats.longestCompletedTask != null
                      ? () => _showTaskForm(context, stats.longestCompletedTask!)
                      : null,
                  child: const Text('Longest'),
                ),
              ),
              horizontalMargin16,
              Expanded(
                child: FocusButton(
                  onTap: stats.longestIncompleteTask != null
                      ? () => _showTaskForm(context, stats.longestIncompleteTask!)
                      : null,
                  child: const Text('Outstanding'),
                ),
              ),
            ],
          ),
        ),
        verticalMargin16,
        const Padding(
          padding: horizontalPadding16,
          child: Text('Completion time (shortest/avgerage/longest):'),
        ),
        Padding(
          padding: leftPadding32 + rightPadding16,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  stats.shortestCompletionTime.asText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),
              verticalMargin8,
              Expanded(
                child: Text(
                  stats.averageCompletionTime.asText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),
              verticalMargin8,
              Expanded(
                child: Text(
                  stats.longestCompletionTime.asText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        verticalMargin8,
        const Padding(
          padding: horizontalPadding16,
          child: Text('Longest open task time:'),
        ),
        Padding(
          padding: leftPadding32 + rightPadding16,
          child: Text(
            stats.longestRunningTaskTime.asText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
        ),
        verticalMargin8,
      ],
    );
  }
}
