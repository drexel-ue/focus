import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/tasks/repository/tasks_repository.dart';
import 'package:focus_flutter/features/widget/digits_only_input_formatter.dart';
import 'package:focus_flutter/features/widget/focus_button.dart';
import 'package:focus_flutter/features/widget/loading_cover.dart';

/// Form for creating/editing a [Task].
@immutable
class TaskForm extends ConsumerStatefulWidget {
  /// Constructs a const [TaskForm].
  const TaskForm({
    super.key,
    required this.close,
    this.task,
  });

  /// Callback to call when cancelling.
  final VoidCallback close;

  /// [Task] to edit.
  final Task? task;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskFormState();
}

class _TaskFormState extends ConsumerState<TaskForm> {
  late final _titleController = TextEditingController(text: widget.task?.title)
    ..addListener(_listener);
  late final _descriptionController = TextEditingController(text: widget.task?.description);
  late final _abilityExpValues = <Ability, TextEditingController>{
    for (final ability in Ability.values) //
      ability: TextEditingController(
        text: widget.task?.abilityExpValues
                .firstWhere((el) => el.ability == ability)
                .exp
                .toString() ??
            '0',
      )..addListener(_listener),
  };

  void _listener() => setState(() {});

  bool get _createEnabled {
    if (widget.task case Task task) {
      final titleChanged = _titleController.text != task.title;
      final descriptionChanged = _descriptionController.text != task.description;
      final expValuesChanged = _abilityExpValues.entries.any((entry) {
        final expValue = int.parse(entry.value.text);
        final taskExpValue = task.abilityExpValues.firstWhere((el) => el.ability == entry.key).exp;
        return expValue != taskExpValue;
      });
      return titleChanged || descriptionChanged || expValuesChanged;
    } else {
      if (_titleController.text.isEmpty) {
        return false;
      }
      if (_abilityExpValues.values.none((controller) => int.parse(controller.text) > 0)) {
        return false;
      }
      return true;
    }
  }

  Future<void> _submit() async {
    if (widget.task case Task task) {
      await ref.read(taskRepositoryProvider.notifier).updateTask(
            taskId: task.id!,
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            abilityExpValues: _abilityExpValues.entries.map<AbilityExperienceValue>((entry) {
              return AbilityExperienceValue(
                ability: entry.key,
                exp: int.parse(entry.value.text),
              );
            }).toList(),
          );
    } else {
      await ref.read(taskRepositoryProvider.notifier).createTask(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            abilityExpValues: _abilityExpValues.entries.map<AbilityExperienceValue>((entry) {
              return AbilityExperienceValue(
                ability: entry.key,
                exp: int.parse(entry.value.text),
              );
            }).toList(),
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
    for (final controller in _abilityExpValues.values) {
      controller
        ..removeListener(_listener)
        ..dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 500.0,
        maxHeight: 700.0,
      ),
      child: LoadingCover(
        loading: ref.watch(taskRepositoryProvider).isLoading,
        child: Padding(
          padding: allPadding16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
              verticalMargin16,
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisExtent: 48.0,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                ),
                itemCount: Ability.values.length,
                itemBuilder: (BuildContext context, int index) {
                  final ability = Ability.values[index];
                  return Row(
                    children: [
                      Expanded(child: Text(ability.name.substring(0, 3).toUpperCase())),
                      horizontalMargin8,
                      Expanded(
                        child: TextField(
                          controller: _abilityExpValues[ability],
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            DigitOnlyInputFormatter(),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ],
                  );
                },
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
                      onTap: () => widget.close(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  horizontalMargin16,
                  Expanded(
                    child: FocusButton(
                      onTap: () => _submit(),
                      filled: true,
                      enabled: _createEnabled,
                      child: Text(widget.task != null ? 'Update' : 'Create'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
