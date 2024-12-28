import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/tasks/repository/tasks_repository.dart';
import 'package:focus_flutter/features/widget/digits_only_input_formatter.dart';
import 'package:focus_flutter/features/widget/focus_button.dart';

/// Form for creating [Task]s.
@immutable
class CreateTaskForm extends ConsumerStatefulWidget {
  /// Constructs a const [CreateTaskForm].
  const CreateTaskForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateTaskFormState();
}

class _CreateTaskFormState extends ConsumerState<CreateTaskForm> {
  late final _titleController = TextEditingController()..addListener(_listener);
  late final _descriptionController = TextEditingController();
  late final _abilityExpValues = <Ability, TextEditingController>{
    for (final ability in Ability.values) //
      ability: TextEditingController(text: '0')..addListener(_listener),
  };

  void _listener() => setState(() {});

  bool get _createEnabled {
    if (_titleController.text.isEmpty) {
      return false;
    }
    if (_abilityExpValues.values.none((controller) => int.parse(controller.text) > 0)) {
      return false;
    }
    return true;
  }

  Future<void> _createTask() async {
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
    return Stack(
      children: [
        Padding(
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
                      onTap: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  horizontalMargin16,
                  Expanded(
                    child: FocusButton(
                      onTap: () => _createTask(),
                      filled: true,
                      enabled: _createEnabled,
                      child: const Text('Create'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (ref.watch(taskRepositoryProvider).isLoading) //
          const Material(
            color: Colors.white54,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
