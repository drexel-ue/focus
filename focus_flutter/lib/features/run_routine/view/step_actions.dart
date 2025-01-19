import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/run_routine/repository/run_routine_repository.dart';
import 'package:focus_flutter/features/run_routine/view/abort_routine_modal.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';

/// Step actions.
@immutable
class StepActions extends ConsumerWidget {
  /// Constructs a const [StepActions].
  StepActions({
    super.key,
    required this.done,
    required this.iteration,
    required this.repeats,
    ValueNotifier<bool>? nextEnabled,
  }) : nextEnabled = nextEnabled ?? ValueNotifier(true);

  /// Callback for when iteration is done.
  final VoidCallback done;

  /// Iteration.
  final ValueNotifier<int> iteration;

  /// Repeats.
  final int repeats;

  /// Next button enabled?
  final ValueNotifier<bool> nextEnabled;

  bool get _isDone => iteration.value >= repeats;

  String _buttonText(WidgetRef ref) {
    if (_isDone) {
      return 'Done';
    }
    if (ref.read(runRoutineRepositoryProvider).requireValue.restDuration > Duration.zero) {
      return 'Rest';
    }
    return 'Next';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: FocusButton(
            onTap: () => AbortRoutineModal.show(context, ref),
            child: const Text('Abort'),
          ),
        ),
        horizontalMargin16,
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: nextEnabled,
            builder: (BuildContext context, bool value, Widget? child) {
              return FocusButton(
                onTap: () => done(),
                filled: true,
                enabled: nextEnabled.value,
                child: ValueListenableBuilder(
                  valueListenable: iteration,
                  builder: (BuildContext context, int value, Widget? child) {
                    return Text(_buttonText(ref));
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
