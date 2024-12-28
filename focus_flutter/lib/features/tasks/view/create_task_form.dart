import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
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
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late final _abilityExpValues = <Ability, TextEditingController>{
    for (final ability in Ability.values) //
      ability: TextEditingController(text: '0'),
  };

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    for (final controller in _abilityExpValues.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  onTap: () {},
                  child: const Text('Cancel'),
                ),
              ),
              horizontalMargin16,
              Expanded(
                child: FocusButton(
                  onTap: () {},
                  filled: true,
                  child: const Text('Create'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
