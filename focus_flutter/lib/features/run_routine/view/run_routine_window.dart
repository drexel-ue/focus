import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/run_routine/repository/run_routine_repository.dart';
import 'package:focus_flutter/features/run_routine/view/binary_step_page.dart';
import 'package:focus_flutter/features/run_routine/view/duration_step_page.dart';
import 'package:focus_flutter/features/run_routine/view/routine_complete_page.dart';
import 'package:focus_flutter/features/run_routine/view/start_routine_page.dart';
import 'package:focus_flutter/features/run_routine/view/tally_step_page.dart';
import 'package:focus_flutter/features/run_routine/view/time_out_countdown.dart';
import 'package:focus_flutter/features/widgets/focus_window.dart';
import 'package:focus_flutter/features/widgets/loading_cover.dart';

/// Runs a [Routine].
@immutable
class RunRoutineWindow extends ConsumerStatefulWidget {
  /// Constructs a const [RunRoutineWindow].
  const RunRoutineWindow._();

  /// Shows a [RunRoutineWindow].
  static Future<void> show(BuildContext context) async {
    return await FocusWindow.show(
      context,
      (BuildContext context, CloseWindow closeWindow) => const RunRoutineWindow._(),
      barrierDismissible: false,
    );
  }

  @override
  ConsumerState<RunRoutineWindow> createState() => _RunRoutineModalState();
}

class _RunRoutineModalState extends ConsumerState<RunRoutineWindow> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _moveToNext() => _pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(runRoutineRepositoryProvider);
    final routine = state.requireValue.routine;
    if (routine == null) {
      return emptyWidget;
    }
    return LoadingCover(
      loading: state.isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalMargin16,
          const Padding(
            padding: horizontalPadding16,
            child: TimeOutCountdown(),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                StartRoutinePage(onStart: _moveToNext),
                for (final step in routine.steps) //
                  if (step.type == RoutineStepType.binary) //
                    BinaryStepPage(step: step, onComplete: _moveToNext)
                  else if (step.type == RoutineStepType.duration) //
                    DurationStepPage(step: step, onComplete: _moveToNext)
                  else if (step.type == RoutineStepType.tally) //
                    TallyStepPage(step: step, onComplete: _moveToNext),
                const RoutineCompletePage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
