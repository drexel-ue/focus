import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/run_routine/repository/run_routine_repository.dart';
import 'package:focus_flutter/features/widgets/ability_stats_display.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/focus_choice_chip.dart';
import 'package:focus_flutter/features/widgets/scroll_shadow.dart';

/// Start Routine Page.
@immutable
class StartRoutinePage extends ConsumerWidget {
  /// Constructs a const [StartRoutinePage].
  const StartRoutinePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routine = ref.watch(runRoutineRepositoryProvider).requireValue.routine!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        verticalMargin16,
        Padding(
          padding: horizontalPadding16,
          child: Text(
            'Routine: ${routine.title}',
            style: TextTheme.of(context).titleMedium,
          ),
        ),
        verticalMargin16,
        Expanded(
          child: ScrollShadow(
            padding: horizontalPadding16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ExpansionTile(
                  title: const Text('Rewards'),
                  children: [
                    AbilityStatsDisplay(stats: routine.stats),
                    verticalMargin16,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 4.0,
                        children: [
                          for (final buff in routine.buffs) //
                            FocusChoiceChip(
                              label: buff.name,
                              selected: true,
                              selectedColor: buff.color,
                              onSelected: (bool selected) {},
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Punishments'),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 4.0,
                        children: [
                          for (final debuff in routine.debuffs) //
                            FocusChoiceChip(
                              label: debuff.name,
                              selected: true,
                              selectedColor: debuff.color,
                              onSelected: (bool selected) {},
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: allPadding16 - topPadding16,
          child: Row(
            children: [
              Expanded(
                child: FocusButton(
                  onTap: () {},
                  child: const Text('Abort'),
                ),
              ),
              horizontalMargin16,
              Expanded(
                child: FocusButton(
                  onTap: () {},
                  filled: true,
                  child: const Text('Start'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
