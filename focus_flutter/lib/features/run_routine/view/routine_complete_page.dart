import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/run_routine/repository/run_routine_repository.dart';
import 'package:focus_flutter/features/widgets/ability_stats_display.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/scroll_shadow.dart';
import 'package:focus_flutter/features/widgets/user_buff_wrap.dart';

/// Routine complete page.
@immutable
class RoutineCompletePage extends ConsumerWidget {
  /// Constructs a const [RoutineCompletePage].
  const RoutineCompletePage({super.key});

  Future<void> _completeRoutine(BuildContext context, WidgetRef ref) async {
    await ref.read(runRoutineRepositoryProvider.notifier).completeRoutine();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routine = ref.watch(runRoutineRepositoryProvider).requireValue.routine!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ScrollShadow(
            padding: allPadding16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Routine complete!',
                  textAlign: TextAlign.center,
                  style: TextTheme.of(context).titleLarge,
                ),
                verticalMargin16,
                const Text(
                  'Press [Accpet] to complete the [Routine] and receive the following rewards:',
                  textAlign: TextAlign.center,
                ),
                ExpansionTile(
                  title: const Text('Rewards'),
                  initiallyExpanded: true,
                  children: [
                    AbilityStatsDisplay(stats: routine.stats),
                    verticalMargin16,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: UserBuffWrap(
                        buffs: routine.buffs,
                        isSelected: (buff) => true,
                        onSelected: (bool selected, buff) {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: allPadding16,
          child: FocusButton(
            onTap: () => _completeRoutine(context, ref),
            filled: true,
            child: const Text('Accept'),
          ),
        ),
      ],
    );
  }
}
