import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/tasks/repository/tasks_repository.dart';
import 'package:focus_flutter/features/tasks/view/delete_task_modal.dart';
import 'package:focus_flutter/features/tasks/view/task_form.dart';
import 'package:focus_flutter/features/widget/focus_button.dart';
import 'package:focus_flutter/features/widget/focus_checkbox.dart';
import 'package:focus_flutter/features/widget/focus_modal.dart';

/// Tasks Page.
@immutable
class TasksPage extends ConsumerWidget {
  /// Construcs a const [TasksPage].
  const TasksPage({super.key});

  static const _formConstraints = BoxConstraints(
    maxWidth: 500.0,
    maxHeight: 700.0,
  );

  void _showTaskForm(BuildContext context, [Task? task]) => FocusModal.show(
        context,
        (BuildContext context, VoidCallback closeModal) => TaskForm(close: closeModal, task: task),
        constraints: _formConstraints,
      );

  void _showDeleteModal(BuildContext context, Task task) => FocusModal.show(
        context,
        (_, VoidCallback close) => DeleteTaskModal(task: task, close: close),
        constraints: const BoxConstraints(
          maxWidth: 500.0,
          maxHeight: 400.0,
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskRepositoryProvider).value?.tasks ?? const <Task>[];
    final notifier = ref.read(taskRepositoryProvider.notifier);
    if (tasks.isEmpty) {
      return Center(
        child: SizedBox(
          width: 200.0,
          child: FocusButton(
            onTap: () => _showTaskForm(context),
            child: const Text('Create task'),
          ),
        ),
      );
    }
    return Padding(
      padding: allPadding16 - bottomPadding16,
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [StretchMode.fadeTitle],
            ),
          ),
          SliverList.builder(
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              final task = tasks[index];
              return Padding(
                padding: bottomPadding16,
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (_) => _showDeleteModal(context, task),
                        icon: Icons.delete_forever_sharp,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ],
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () => _showTaskForm(context, task),
                    child: Row(
                      children: [
                        FocusCheckbox(
                          onTap: () => notifier.toggleTaskComplete(task.id!),
                          selected: task.completed,
                        ),
                        horizontalMargin16,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                task.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextTheme.of(context).titleMedium,
                              ),
                              if (task.description case String description) ...[
                                // verticalMargin4,
                                Text(
                                  description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
