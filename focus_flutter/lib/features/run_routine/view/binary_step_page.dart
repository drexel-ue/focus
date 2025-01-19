import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/run_routine/repository/run_routine_repository.dart';
import 'package:focus_flutter/features/run_routine/view/abort_routine_modal.dart';
import 'package:focus_flutter/features/run_routine/view/rest_modal.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';

/// Binary step page.
@immutable
class BinaryStepPage extends ConsumerStatefulWidget {
  /// Constructs a const [BinaryStepPage].
  const BinaryStepPage({
    super.key,
    required this.step,
    required this.onComplete,
  });

  /// [RoutineStep].
  final RoutineStep step;

  /// Callback to run when binary step is completed.
  final VoidCallback onComplete;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BinaryStepPageState();
}

class _BinaryStepPageState extends ConsumerState<BinaryStepPage> {
  final _iteration = ValueNotifier(0);

  Future<void> _done() async {
    final steps = ref.read(runRoutineRepositoryProvider).requireValue.routine!.steps;
    final currentIndex = steps.indexOf(widget.step);
    final isLastStep = currentIndex == steps.length - 1;
    String? nextStep;
    if (!isDone) {
      nextStep = widget.step.title;
    } else if (!isLastStep) {
      nextStep = steps[currentIndex + 1].title;
    }
    if (ref.read(runRoutineRepositoryProvider).requireValue.restDuration > Duration.zero) {
      await RestModal.show(context, nextStep);
    }
    if (!isDone) {
      _iteration.value += 1;
    } else {
      widget.onComplete();
    }
  }

  bool get isDone => _iteration.value >= widget.step.repeats;

  String get buttonText {
    if (isDone) {
      return 'Done';
    }
    if (ref.read(runRoutineRepositoryProvider).requireValue.restDuration > Duration.zero) {
      return 'Rest';
    }
    return 'Next';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: allPadding16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          spacer,
          Padding(
            padding: horizontalPadding16,
            child: Text(
              widget.step.title,
              style: TextTheme.of(context).titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          verticalMargin16,
          Padding(
            padding: horizontalPadding16,
            child: ValueListenableBuilder(
              valueListenable: _iteration,
              builder: (BuildContext context, int value, Widget? child) {
                return Text(
                  '${_iteration.value + 1}/${widget.step.repeats + 1}',
                  style: TextTheme.of(context).titleMedium,
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
          spacer,
          Row(
            children: [
              Expanded(
                child: FocusButton(
                  onTap: () => AbortRoutineModal.show(context, ref),
                  child: const Text('Abort'),
                ),
              ),
              horizontalMargin16,
              Expanded(
                child: FocusButton(
                  onTap: () => _done(),
                  filled: true,
                  child: ValueListenableBuilder(
                    valueListenable: _iteration,
                    builder: (BuildContext context, int value, Widget? child) {
                      return Text(buttonText);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
