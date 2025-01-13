import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/tasks/repository/tasks_repository.dart';
import 'package:focus_flutter/features/tasks/view/delete_task_modal.dart';
import 'package:focus_flutter/features/tasks/view/task_form.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/focus_checkbox.dart';
import 'package:focus_flutter/features/widgets/focus_modal.dart';

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
    FocusModal.show(
      context,
      (BuildContext context, CloseModal closeModal) {
        return TaskForm(task: task);
      },
    );
  }

  void _showDeleteModal(BuildContext context, Task task) => FocusModal.show(
        context,
        (_, VoidCallback close) => DeleteTaskModal(task: task, close: close),
        constraints: const BoxConstraints(
          maxWidth: 500.0,
          maxHeight: 400.0,
        ),
      );

  @override
  Widget build(BuildContext context) {
    var tasks = ref.watch(taskRepositoryProvider).value?.tasks ?? const <Task>[];
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
    final stat = tasks.fold(
      UserAbilityStats(
        strengthExp: 0,
        vitalityExp: 0,
        agilityExp: 0,
        intelligenceExp: 0,
        perceptionExp: 0,
      ),
      (UserAbilityStats folded, Task task) {
        if (task.completed) {
          return folded;
        }
        return folded + task.abilityExpValues;
      },
    );
    return Padding(
      padding: horizontalPadding16 + topPadding2,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            actions: [
              IconButton(
                onPressed: () => _showTaskForm(context),
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ],
            expandedHeight: 160.0,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.fadeTitle],
              background: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  verticalMargin16,
                  Text('Complete: ${tasks.where((task) => task.completed).length}'),
                  Text('Incomplete: ${tasks.whereNot((task) => task.completed).length}'),
                  Text('STR avail: ${stat.strengthExp}'),
                  Text('VIT avail: ${stat.vitalityExp}'),
                  Text('AGI avail: ${stat.agilityExp}'),
                  Text('INT avail: ${stat.intelligenceExp}'),
                  Text('PER avail: ${stat.perceptionExp}'),
                ],
              ),
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
