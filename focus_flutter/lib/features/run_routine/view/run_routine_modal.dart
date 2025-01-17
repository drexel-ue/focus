import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_flutter/features/run_routine/repository/run_routine_repository.dart';
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(runRoutineRepositoryProvider);
    final routine = state.requireValue.routine!;
    final record = state.requireValue.record!;
    return LoadingCover(
      loading: state.isLoading,
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Center(child: Text('Run Routine')),
        ],
      ),
    );
  }
}
