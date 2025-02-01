import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/run_routine/repository/run_routine_repository.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/focus_window.dart';
import 'package:focus_flutter/features/widgets/user_debuff_wrap.dart';

/// Confirms aborting a [Routine].
@immutable
class AbortRoutineModal extends ConsumerWidget {
  /// Constructs a const [AbortRoutineModal].
  const AbortRoutineModal._({required this.closeModal});

  /// Shows the [AbortRoutineModal].
  static Future<void> show(BuildContext context, WidgetRef ref) async {
    final abort = await FocusWindow.show<bool>(
      context,
      (BuildContext context, CloseWindow closeModal) => AbortRoutineModal._(closeModal: closeModal),
    );
    if (abort == true) {
      await ref.read(runRoutineRepositoryProvider.notifier).abortRoutine();
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  /// Callback to run when modal is closed.
  final CloseWindow closeModal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routine = ref.watch(runRoutineRepositoryProvider).requireValue.routine;
    return Padding(
      padding: allPadding16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Abort Routine?',
            textAlign: TextAlign.center,
            style: TextTheme.of(context).titleMedium,
          ),
          verticalMargin16,
          const Text(
            'You will receive the following debuffs:',
            textAlign: TextAlign.center,
          ),
          verticalMargin8,
          UserDebuffWrap(
            debuffs: routine?.debuffs ?? [],
            isSelected: (debuff) => true,
          ),
          verticalMargin16,
          verticalMargin16,
          Row(
            children: [
              Expanded(
                child: FocusButton(
                  onTap: () => closeModal(false),
                  child: const Text('Cancel'),
                ),
              ),
              horizontalMargin16,
              Expanded(
                child: FocusButton(
                  onTap: () => closeModal(true),
                  filled: true,
                  child: const Text('Abort'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
