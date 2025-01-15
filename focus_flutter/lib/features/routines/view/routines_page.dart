import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/features/routines/repository/routines_repository.dart';
import 'package:focus_flutter/features/routines/view/routine_form.dart';
import 'package:focus_flutter/features/widgets/crud_list_item_view.dart';
import 'package:focus_flutter/features/widgets/focus_modal.dart';

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
    FocusModal.show(
      context,
      (BuildContext context, CloseModal closeModal) => RoutineForm(routine: routine),
    );
  }

  void _showDeleteModal(BuildContext context, [Routine? routine]) {
    // TODO(drexel-ue): implement
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
    );
  }
}
