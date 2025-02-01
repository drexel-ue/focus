import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/features/routines/repository/routines_repository.dart';
import 'package:focus_flutter/features/routines/view/delete_routine_modal.dart';
import 'package:focus_flutter/features/routines/view/routine_form.dart';
import 'package:focus_flutter/features/run_routine/repository/run_routine_repository.dart';
import 'package:focus_flutter/features/run_routine/view/run_routine_window.dart';
import 'package:focus_flutter/features/widgets/crud_list_item_view.dart';
import 'package:focus_flutter/features/widgets/focus_window.dart';

/// Routines Page.
@immutable
class RoutinesPage extends ConsumerStatefulWidget {
  /// Construcs a const [RoutinesPage].
  const RoutinesPage({super.key});

  @override
  ConsumerState<RoutinesPage> createState() => _RoutinesPageState();
}

class _RoutinesPageState extends ConsumerState<RoutinesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(routinesRepositoryProvider.notifier).loadRoutines();
    });
  }

  void _showRoutineForm(BuildContext context, [Routine? routine]) {
    FocusWindow.show(
      context,
      (BuildContext context, CloseWindow closeModal) => RoutineForm(routine: routine),
    );
  }

  void _showDeleteModal(BuildContext context, Routine routine) => FocusWindow.show(
        context,
        (_, __) => DeleteRoutineModal(routine: routine),
      );

  Future<void> _runRoutine(BuildContext context, Routine routine) async {
    await ref.read(runRoutineRepositoryProvider.notifier).runRoutine(routine);
    if (context.mounted) {
      RunRoutineWindow.show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var routines = ref.watch(routinesRepositoryProvider).value?.routines ?? const <Routine>[];
    return CrudListItemView<Routine>(
      items: routines,
      getTitle: (routine) => routine.title,
      getDescription: (routine) => null,
      onAddItem: () => _showRoutineForm(context),
      onDeleteItem: (routine) => _showDeleteModal(context, routine),
      onItemTapped: (routine) => _showRoutineForm(context, routine),
      trailing: const Icon(Icons.play_arrow_outlined),
      onTrailingTapped: (routine) => _runRoutine(context, routine),
    );
  }
}
