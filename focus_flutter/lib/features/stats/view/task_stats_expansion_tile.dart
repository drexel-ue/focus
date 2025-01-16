import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/stats/repository/stats_repository.dart';
import 'package:focus_flutter/features/widgets/ability_stats_display.dart';

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
        const Padding(
          padding: horizontalPadding16,
          child: Text('Completion time (shortest/avgerage/longest):'),
        ),
        Padding(
          padding: leftPadding32 + rightPadding16,
          child: Row(
            children: [
              Expanded(child: Text('${stats.shortestCompletionTime}')),
              Expanded(child: Text('${stats.averageCompletionTime}')),
              Expanded(child: Text('${stats.longestCompletionTime}')),
            ],
          ),
        ),
        verticalMargin8,
        const Padding(
          padding: horizontalPadding16,
          child: Text('Stats gained:'),
        ),
        Padding(
          padding: leftPadding32 + rightPadding16,
          child: AbilityStatsDisplay(stats: stats.completedStats),
        ),
        verticalMargin8,
        const Padding(
          padding: horizontalPadding16,
          child: Text('Stats on table:'),
        ),
        Padding(
          padding: leftPadding32 + rightPadding16,
          child: AbilityStatsDisplay(stats: stats.incompleteStats),
        ),
        verticalMargin8,
      ],
    );
  }
}
