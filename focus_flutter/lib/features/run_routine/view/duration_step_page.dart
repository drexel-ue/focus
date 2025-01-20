import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/run_routine/repository/run_routine_repository.dart';
import 'package:focus_flutter/features/run_routine/view/rest_modal.dart';
import 'package:focus_flutter/features/run_routine/view/step_actions.dart';
import 'package:focus_flutter/features/run_routine/view/step_title_and_iteration.dart';
import 'package:focus_flutter/features/widgets/focus_countdown_timer.dart';

/// Duration step page.
@immutable
class DurationStepPage extends ConsumerStatefulWidget {
  /// Constructs a const [DurationStepPage].
  const DurationStepPage({
    super.key,
    required this.step,
    required this.onComplete,
  });

  /// [RoutineStep].
  final RoutineStep step;

  /// Callback to run when duration step is completed.
  final VoidCallback onComplete;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DurationStepPageState();
}

class _DurationStepPageState extends ConsumerState<DurationStepPage> {
  final _iteration = ValueNotifier<int>(0);
  final _timerComplete = ValueNotifier<bool>(false);

  bool get isDone => _iteration.value >= widget.step.repeats;

  Future<void> _onTimerComplete() async {
    // FIXME(drexel-ue): why does the timer run an extra time?
    if (!_timerComplete.value) {
      _timerComplete.value = true;
    }
    if (!isDone) {
      await _done();
      _timerComplete.value = false;
    }
  }

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
    } else {
      widget.onComplete();
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
            valueListenable: _timerComplete,
            builder: (BuildContext context, bool value, Widget? child) {
              return Center(
                child: FocusCountdownTimer(
                  key: UniqueKey(),
                  duration: widget.step.duration!,
                  onFinished: _onTimerComplete,
                ),
              );
            },
          ),
          spacer,
          StepActions(
            done: _done,
            iteration: _iteration,
            nextEnabled: _timerComplete,
            repeats: widget.step.repeats,
          ),
        ],
      ),
    );
  }
}
