import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/tasks/repository/tasks_repository.dart';
import 'package:focus_flutter/features/widget/focus_button.dart';
import 'package:focus_flutter/features/widget/focus_modal.dart';

/// Tasks Page.
@immutable
class TasksPage extends ConsumerWidget {
  /// Construcs a const [TasksPage].
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskRepositoryProvider).value?.tasks ?? const <Task>[];
    if (tasks.isEmpty) {
      return Center(
        child: SizedBox(
          width: 200.0,
          child: FocusButton(
            onTap: () => FocusModal.show(context),
            child: const Text('Create task'),
          ),
        ),
      );
    }
    return const Padding(
      padding: allPadding16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [],
      ),
    );
  }
}
