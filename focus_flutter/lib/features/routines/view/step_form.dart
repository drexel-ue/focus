import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/tasks/repository/tasks_repository.dart';
import 'package:focus_flutter/features/widgets/digits_only_input_formatter.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/focus_modal.dart';
import 'package:focus_flutter/features/widgets/loading_cover.dart';

/// Form for creating/editing a [RoutineStep].
@immutable
class StepForm extends ConsumerStatefulWidget {
  /// Constructs a const [StepForm].
  const StepForm({
    super.key,
    required this.close,
    this.step,
  });

  /// Callback to call when cancelling.
  final CloseModal<RoutineStep?> close;

  /// [RoutineStep] to edit.
  final RoutineStep? step;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StepFormState();
}

class _StepFormState extends ConsumerState<StepForm> {
  late final _titleController = TextEditingController(text: widget.step?.title)
    ..addListener(_listener);
  late RoutineStepType _type = widget.step?.type ?? RoutineStepType.binary;
  late Duration? _duration = widget.step?.duration;
  late int? _tally = widget.step?.tally;
  late int _repeats = widget.step?.repeats ?? 0;
  late final _abilityExpValues = <Ability, TextEditingController>{
    for (final ability in Ability.values) //
      ability: TextEditingController(
        text: widget.step?.abilityExpValues.expFor(ability).toString() ?? '0',
      )..addListener(_listener),
  };

  void _listener() => setState(() {});

  bool get _createEnabled {
    if (widget.step case RoutineStep step) {
      final titleChanged = _titleController.text != step.title;
      final expValuesChanged = _abilityExpValues.entries.any((entry) {
        final expValue = int.parse(entry.value.text);
        final taskExpValue = step.abilityExpValues.expFor(entry.key);
        return expValue != taskExpValue;
      });
      final typeValueChanged = switch (_type) {
        RoutineStepType.binary => true,
        RoutineStepType.duration => step.duration != _duration,
        RoutineStepType.tally => step.tally != _tally,
      };
      return titleChanged || expValuesChanged || typeValueChanged;
    } else {
      if (_titleController.text.isEmpty) {
        return false;
      }
      if (_abilityExpValues.values.none((controller) => int.parse(controller.text) > 0)) {
        return false;
      }
      return switch (_type) {
        RoutineStepType.binary => true,
        RoutineStepType.duration => (_duration ?? Duration.zero) > Duration.zero,
        RoutineStepType.tally => (_tally ?? 0) > 0,
      };
    }
  }

  Future<void> _submit() async {
    final abilityExpValues = UserAbilityStats(
      strengthExp: int.parse(_abilityExpValues[Ability.strength]!.text),
      vitalityExp: int.parse(_abilityExpValues[Ability.vitality]!.text),
      agilityExp: int.parse(_abilityExpValues[Ability.agility]!.text),
      intelligenceExp: int.parse(_abilityExpValues[Ability.intelligence]!.text),
      perceptionExp: int.parse(_abilityExpValues[Ability.perception]!.text),
    );
    if (mounted) {
      widget.close(
        RoutineStep(
          title: _titleController.text,
          type: _type,
          abilityExpValues: abilityExpValues,
          duration: _duration,
          tally: _tally,
          repeats: _repeats,
        ),
      );
    }
  }

  @override
  void dispose() {
    _titleController
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
    return LoadingCover(
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
            Align(
              alignment: Alignment.centerLeft,
              child: DropdownMenu<RoutineStepType>(
                initialSelection: _type,
                dropdownMenuEntries: [
                  for (final type in RoutineStepType.values) //
                    DropdownMenuEntry(
                      value: type,
                      label: type.name,
                    ),
                ],
                onSelected: (type) {
                  if (type == null) {
                    return;
                  }
                  setState(() => _type = type);
                },
              ),
            ),
            spacer,
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
                    child: Text(widget.step != null ? 'Update' : 'Add'),
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
