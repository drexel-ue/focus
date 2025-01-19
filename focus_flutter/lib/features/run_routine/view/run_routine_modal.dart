import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/run_routine/repository/run_routine_repository.dart';
import 'package:focus_flutter/features/run_routine/view/binary_step_page.dart';
import 'package:focus_flutter/features/run_routine/view/duration_step_page.dart';
import 'package:focus_flutter/features/run_routine/view/rest_modal.dart';
import 'package:focus_flutter/features/run_routine/view/start_routine_page.dart';
import 'package:focus_flutter/features/run_routine/view/tally_step_page.dart';
import 'package:focus_flutter/features/widgets/focus_modal.dart';
import 'package:focus_flutter/features/widgets/loading_cover.dart';

/// Runs a [Routine].
@immutable
class RunRoutineModal extends ConsumerStatefulWidget {
  /// Constructs a const [RunRoutineModal].
  const RunRoutineModal({super.key});

  @override
  ConsumerState<RunRoutineModal> createState() => _RunRoutineModalState();
}

class _RunRoutineModalState extends ConsumerState<RunRoutineModal> {
  late final PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _page);
  }

  void _moveToNext() => _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
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
    final record = state.requireValue.record;
    if (routine == null) {
      return emptyWidget;
    }
    return LoadingCover(
      loading: state.isLoading,
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (int page) => _page = page,
        children: [
          const StartRoutinePage(),
          for (final step in routine.steps) //
            if (step.type == RoutineStepType.binary) //
              BinaryStepPage(step: step, onComplete: _moveToNext)
            else if (step.type == RoutineStepType.duration) //
              DurationStepPage(step: step, onComplete: _moveToNext)
            else if (step.type == RoutineStepType.tally) //
              TallyStepPage(step: step, onComplete: _moveToNext),
        ],
      ),
    );
  }
}
