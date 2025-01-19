import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/run_routine/repository/run_routine_repository.dart';
import 'package:focus_flutter/features/run_routine/view/focus_tally_counter.dart';
import 'package:focus_flutter/features/run_routine/view/rest_modal.dart';
import 'package:focus_flutter/features/run_routine/view/step_actions.dart';
import 'package:focus_flutter/features/run_routine/view/step_title_and_iteration.dart';

/// Tally step page.
@immutable
class TallyStepPage extends ConsumerStatefulWidget {
  /// Constructs a const [TallyStepPage].
  const TallyStepPage({
    super.key,
    required this.step,
    required this.onComplete,
  });

  /// [RoutineStep].
  final RoutineStep step;

  /// Callback to run when tally step is completed.
  final VoidCallback onComplete;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TallyStepPageState();
}

class _TallyStepPageState extends ConsumerState<TallyStepPage> {
  final _iteration = ValueNotifier<int>(0);
  final _tally = ValueNotifier<int>(0);
  final _tallyReached = ValueNotifier<bool>(false);

  bool get isDone => _iteration.value >= widget.step.repeats;

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
    if (ref.read(runRoutineRepositoryProvider).requireValue.restDuration > Duration.zero &&
        _iteration.value < widget.step.repeats) {
      await RestModal.show(context, nextStep);
    }
    if (!isDone) {
      _iteration.value += 1;
      _tally.value = 0;
      _tallyReached.value = false;
    } else {
      widget.onComplete();
    }
  }

  void _onTallyChanged(int value) {
    _tally.value = value;
    if (value >= widget.step.tally!) {
      _tallyReached.value = true;
    }
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
            child: StepTitleAndIteration(
              title: widget.step.title,
              iteration: _iteration,
              repeats: widget.step.repeats,
            ),
          ),
          verticalMargin16,
          ValueListenableBuilder(
            valueListenable: _tallyReached,
            builder: (BuildContext context, bool value, Widget? child) {
              return FocusTallyCounter(
                key: UniqueKey(),
                tally: _tally.value,
                onChanged: _onTallyChanged,
              );
            },
          ),
          spacer,
          StepActions(
            done: _done,
            iteration: _iteration,
            nextEnabled: _tallyReached,
            repeats: widget.step.repeats,
          ),
        ],
      ),
    );
  }
}
