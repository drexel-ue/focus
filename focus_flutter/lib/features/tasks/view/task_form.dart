import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/tasks/repository/tasks_repository.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/loading_cover.dart';

/// Form for creating/editing a [Task].
@immutable
class TaskForm extends ConsumerStatefulWidget {
  /// Constructs a const [TaskForm].
  const TaskForm({
    super.key,
    this.task,
  });

  /// [Task] to edit.
  final Task? task;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskFormState();
}

class _TaskFormState extends ConsumerState<TaskForm> {
  late final _titleController = TextEditingController(text: widget.task?.title)
    ..addListener(_listener);
  late final _descriptionController = TextEditingController(text: widget.task?.description)
    ..addListener(_listener);
  final _enabled = ValueNotifier(false);

  bool get _createEnabled {
    if (widget.task case Task task) {
      final titleChanged = _titleController.text != task.title;
      final descriptionChanged = _descriptionController.text != task.description;
      return (titleChanged || descriptionChanged) && task.completed == false;
    } else {
      if (_titleController.text.isEmpty) {
        return false;
      }
      return true;
    }
  }

  void _listener() => _enabled.value = _createEnabled;

  Future<void> _submit() async {
    if (widget.task case Task task) {
      await ref.read(taskRepositoryProvider.notifier).updateTask(
            taskId: task.id!,
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
          );
    } else {
      await ref.read(taskRepositoryProvider.notifier).createTask(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
          );
    }
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _titleController
      ..removeListener(_listener)
      ..dispose();
    _descriptionController
      ..removeListener(_listener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingCover(
      loading: ref.watch(taskRepositoryProvider).isLoading,
      child: Padding(
        padding: allPadding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              cursorColor: AppColors.white,
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
            ),
            verticalMargin16,
            Expanded(
              child: TextField(
                controller: _descriptionController,
                expands: true,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
              ),
            ),
            verticalMargin16,
            Row(
              children: [
                Expanded(
                  child: FocusButton(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ),
                horizontalMargin16,
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: _enabled,
                    builder: (BuildContext context, bool value, Widget? child) {
                      return FocusButton(
                        onTap: () => _submit(),
                        filled: true,
                        enabled: value,
                        child: Text(widget.task != null ? 'Update' : 'Create'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
