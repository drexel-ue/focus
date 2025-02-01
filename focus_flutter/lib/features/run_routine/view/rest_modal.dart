import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/run_routine/repository/run_routine_repository.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/focus_countdown_timer.dart';
import 'package:focus_flutter/features/widgets/focus_window.dart';

/// Rest modal.
@immutable
class RestModal extends ConsumerWidget {
  /// Constructs a const [RestModal].
  const RestModal({
    super.key,
    this.nextStep,
    required this.closeModal,
  });

  /// Shows a [RestModal].
  static Future<void> show(BuildContext context, [String? nextStep]) async {
    await FocusWindow.show<void>(
      context,
      (BuildContext context, CloseWindow closeModal) => RestModal(
        nextStep: nextStep,
        closeModal: closeModal,
      ),
    );
  }

  /// Next step.
  final String? nextStep;

  /// Callback to close modal.
  final CloseWindow closeModal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: allPadding16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Rest',
            textAlign: TextAlign.center,
            style: TextTheme.of(context).titleMedium,
          ),
          verticalMargin16,
          if (nextStep case String nextStep) ...[
            Text(
              'Up next: $nextStep',
              textAlign: TextAlign.center,
            ),
            verticalMargin16,
          ],
          Center(
            child: FocusCountdownTimer(
              duration: ref.watch(runRoutineRepositoryProvider).requireValue.restDuration,
              canPause: true,
              onFinished: () => closeModal(),
              onChange: (Duration duration) {
                ref.read(runRoutineRepositoryProvider.notifier).restDuration = duration;
              },
            ),
          ),
          verticalMargin16,
          FocusButton(
            onTap: () => closeModal(),
            filled: true,
            child: const Text('Skip'),
          ),
        ],
      ),
    );
  }
}
