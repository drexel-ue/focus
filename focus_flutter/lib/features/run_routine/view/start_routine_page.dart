import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/run_routine/repository/run_routine_repository.dart';
import 'package:focus_flutter/features/run_routine/view/abort_routine_modal.dart';
import 'package:focus_flutter/features/widgets/ability_stats_display.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/focus_modal.dart';
import 'package:focus_flutter/features/widgets/scroll_shadow.dart';
import 'package:focus_flutter/features/widgets/user_buff_wrap.dart';
import 'package:focus_flutter/features/widgets/user_debuff_wrap.dart';

/// Start Routine Page.
@immutable
class StartRoutinePage extends ConsumerWidget {
  /// Constructs a const [StartRoutinePage].
  const StartRoutinePage({super.key});

  Future<void> _showAbortModal(BuildContext context, WidgetRef ref) async {
    final abort = await FocusModal.show<bool>(
      context,
      (BuildContext context, CloseModal closeModal) => AbortRoutineModal(closeModal: closeModal),
    );
    if (abort == true) {
      await ref.read(runRoutineRepositoryProvider.notifier).abortRoutine();
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routine = ref.watch(runRoutineRepositoryProvider).requireValue.routine;
    if (routine == null) {
      return emptyWidget;
    }
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
                      child: UserBuffWrap(
                        buffs: routine.buffs,
                        isSelected: (buff) => true,
                        onSelected: (bool selected, buff) {},
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Punishments'),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: UserDebuffWrap(
                        debuffs: routine.debuffs,
                        isSelected: (debuff) => true,
                        onSelected: (bool selected, debuff) {},
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
                  onTap: () => _showAbortModal(context, ref),
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
