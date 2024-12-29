import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/tasks/repository/tasks_repository.dart';
import 'package:focus_flutter/features/tasks/view/task_form.dart';
import 'package:focus_flutter/features/widget/focus_button.dart';
import 'package:focus_flutter/features/widget/focus_checkbox.dart';
import 'package:focus_flutter/features/widget/focus_modal.dart';

/// Tasks Page.
@immutable
class TasksPage extends ConsumerWidget {
  /// Construcs a const [TasksPage].
  const TasksPage({super.key});

  void _showCreateTaskForm(BuildContext context) => FocusModal.show(
        context,
        (BuildContext context, VoidCallback closeModal) => TaskForm(close: closeModal),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskRepositoryProvider).value?.tasks ?? const <Task>[];
    final provider = ref.read(taskRepositoryProvider.notifier);
    if (tasks.isEmpty) {
      return Center(
        child: SizedBox(
          width: 200.0,
          child: FocusButton(
            onTap: () => _showCreateTaskForm(context),
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
                child: InkWell(
                  onTap: () => FocusModal.show(context, (
                    BuildContext context,
                    VoidCallback closeModal,
                  ) {
                    return TaskForm(close: closeModal, task: task);
                  }),
                  child: Row(
                    children: [
                      FocusCheckbox(
                        onTap: () => provider.toggleTaskComplete(task.id!),
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
              );
            },
          ),
        ],
      ),
    );
  }
}
