import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/extensions/duration.dart';
import 'package:focus_flutter/features/routines/view/routine_form.dart';
import 'package:focus_flutter/features/stats/repository/stats_repository.dart';
import 'package:focus_flutter/features/widgets/ability_stats_display.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/focus_window.dart';

/// Displays [RoutineStats].
@immutable
class RoutineStatsExpansionTile extends ConsumerStatefulWidget {
  /// Constructs a const [RoutineStatsExpansionTile].
  const RoutineStatsExpansionTile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoutineStatsExpansionTileState();
}

class _RoutineStatsExpansionTileState extends ConsumerState<RoutineStatsExpansionTile> {
  bool _isExpanded = false;

  void _showRoutineForm(BuildContext context, Routine routine) {
    FocusWindow.show(
      context,
      (BuildContext context, CloseWindow closeModal) {
        return RoutineForm(routine: routine);
      },
    );
  }

  String _shortestCompletionTimeFor(Routine routine) {
    final stats = ref.read(statsRepositoryProvider).requireValue.routineStats!;
    if (stats.shortestCompletionTime[routine] case Duration duration) {
      return duration.asText;
    }
    return 'n/a';
  }

  String _averageCompletionTimeFor(Routine routine) {
    final stats = ref.read(statsRepositoryProvider).requireValue.routineStats!;
    if (stats.averageCompletionTime[routine] case Duration duration) {
      return duration.asText;
    }
    return 'n/a';
  }

  String _longestCompletionTimeFor(Routine routine) {
    final stats = ref.read(statsRepositoryProvider).requireValue.routineStats!;
    if (stats.longestCompletionTime[routine] case Duration duration) {
      return duration.asText;
    }
    return 'n/a';
  }

  @override
  Widget build(BuildContext context) {
    final stats = ref.watch(statsRepositoryProvider).requireValue.routineStats!;
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
                  onTap: stats.mostFrequentTimedOut != null
                      ? () => _showRoutineForm(context, stats.mostFrequentTimedOut!)
                      : null,
                  child: const Text('Timed out'),
                ),
              ),
              horizontalMargin16,
              Expanded(
                child: FocusButton(
                  onTap: stats.mostFrequentAborted != null
                      ? () => _showRoutineForm(context, stats.mostFrequentAborted!)
                      : null,
                  child: const Text('Aborted'),
                ),
              ),
              horizontalMargin16,
              Expanded(
                child: FocusButton(
                  onTap: stats.mostFrequentCompleted != null
                      ? () => _showRoutineForm(context, stats.mostFrequentCompleted!)
                      : null,
                  child: const Text('Completed'),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final routine in stats.routines)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${routine.title}:',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    Padding(
                      padding: leftPadding32 + leftPadding8 + rightPadding16,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _shortestCompletionTimeFor(routine),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          verticalMargin8,
                          Expanded(
                            child: Text(
                              _averageCompletionTimeFor(routine),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          verticalMargin8,
                          Expanded(
                            child: Text(
                              _longestCompletionTimeFor(routine),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
          child: Text('Stats aborted:'),
        ),
        Padding(
          padding: leftPadding32 + rightPadding16,
          child: AbilityStatsDisplay(stats: stats.abortedStats),
        ),
        verticalMargin8,
        const Padding(
          padding: horizontalPadding16,
          child: Text('Stats timed out:'),
        ),
        Padding(
          padding: leftPadding32 + rightPadding16,
          child: AbilityStatsDisplay(stats: stats.timedOutStats),
        ),
        verticalMargin8,
      ],
    );
  }
}
