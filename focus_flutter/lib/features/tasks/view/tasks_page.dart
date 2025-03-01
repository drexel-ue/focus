import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/features/tasks/repository/tasks_repository.dart';
import 'package:focus_flutter/features/tasks/view/delete_task_modal.dart';
import 'package:focus_flutter/features/tasks/view/task_form.dart';
import 'package:focus_flutter/features/widgets/crud_list_item_view.dart';
import 'package:focus_flutter/features/widgets/focus_window.dart';

/// Tasks Page.
@immutable
class TasksPage extends ConsumerStatefulWidget {
  /// Construcs a const [TasksPage].
  const TasksPage({super.key});

  @override
  ConsumerState<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends ConsumerState<TasksPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(taskRepositoryProvider.notifier).loadTasks();
    });
  }

  void _showTaskForm(BuildContext context, [Task? task]) {
    FocusWindow.show(
      context,
      (BuildContext context, CloseWindow closeModal) {
        return TaskForm(task: task);
      },
    );
  }

  void _showDeleteModal(BuildContext context, Task task) => FocusWindow.show(
        context,
        (_, __) => DeleteTaskModal(task: task),
      );

  @override
  Widget build(BuildContext context) {
    var tasks = ref.watch(taskRepositoryProvider).value?.tasks ?? const <Task>[];
    final notifier = ref.read(taskRepositoryProvider.notifier);
    return CrudListItemView<Task>(
      items: tasks,
      getTitle: (task) => task.title,
      getDescription: (task) => task.description,
      onAddItem: () => _showTaskForm(context),
      onDeleteItem: (task) => _showDeleteModal(context, task),
      onItemTapped: (task) => _showTaskForm(context, task),
      onCheckboxTapped: (task) => notifier.completeTask(task.id!),
    );
  }
}
