import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/routines/repository/routines_repository.dart';
import 'package:focus_flutter/features/routines/view/step_form.dart';
import 'package:focus_flutter/features/widgets/focus_border.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/focus_modal.dart';
import 'package:focus_flutter/features/widgets/loading_cover.dart';
import 'package:focus_flutter/features/widgets/scroll_shadow.dart';
import 'package:focus_flutter/features/widgets/user_buff_wrap.dart';
import 'package:focus_flutter/features/widgets/user_debuff_wrap.dart';

/// Form for creating/editing a [Routine].
@immutable
class RoutineForm extends ConsumerStatefulWidget {
  /// Constructs a const [RoutineForm].
  const RoutineForm({
    super.key,
    this.routine,
  });

  /// [Routine] to edit.
  final Routine? routine;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoutineFormState();
}

class _RoutineFormState extends ConsumerState<RoutineForm> {
  late final _titleController = TextEditingController(text: widget.routine?.title)
    ..addListener(_listener);
  late final _buffs = <UserBuff>{...?widget.routine?.buffs};
  late final _debuffs = <UserDebuff>{...?widget.routine?.debuffs};
  late final _steps = <RoutineStep>[...?widget.routine?.steps];

  void _listener() => setState(() {});

  void _onBuffSelected(bool selected, UserBuff buff) {
    setState(() {
      if (selected) {
        _buffs.add(buff);
      } else {
        _buffs.remove(buff);
      }
    });
  }

  void _onDebuffSelected(bool selected, UserDebuff debuff) {
    setState(() {
      if (selected) {
        _debuffs.add(debuff);
      } else {
        _debuffs.remove(debuff);
      }
    });
  }

  void _onReorderSteps(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final step = _steps.removeAt(oldIndex);
    _steps.insert(newIndex, step);
  }

  Future<void> _addStep() async {
    final step = await FocusModal.show(
      context,
      (BuildContext context, CloseModal<RoutineStep?> closeModal) {
        return StepForm(close: closeModal);
      },
    );
    if (step != null) {
      _steps.add(step);
    }
  }

  Future<void> _editStep(int index) async {
    final step = await FocusModal.show(
      context,
      (BuildContext context, CloseModal<RoutineStep?> closeModal) {
        return StepForm(close: closeModal, step: _steps[index]);
      },
    );
    if (step != null) {
      _steps[index] = step;
    }
  }

  bool get _createEnabled => _titleController.text.isNotEmpty && _steps.isNotEmpty;

  Future<void> _submit() async {
    if (widget.routine case Routine routine) {
      await ref.read(routinesRepositoryProvider.notifier).updateRoutine(
            routineId: routine.id!,
            title: _titleController.text.trim(),
            steps: _steps,
            buffs: _buffs.toList(),
            debuffs: _debuffs.toList(),
          );
    } else {
      await ref.read(routinesRepositoryProvider.notifier).createRoutine(
            title: _titleController.text.trim(),
            steps: _steps,
            buffs: _buffs.toList(),
            debuffs: _debuffs.toList(),
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingCover(
      loading: ref.watch(routinesRepositoryProvider).isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalMargin16,
          Padding(
            padding: horizontalPadding16,
            child: TextField(
              controller: _titleController,
              cursorColor: AppColors.white,
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
            ),
          ),
          verticalMargin16,
          Padding(
            padding: horizontalPadding16,
            child: ExpansionTile(
              title: Text('Buffs ${_buffs.isNotEmpty ? '(${_buffs.length})' : ''}'),
              children: [
                UserBuffWrap(
                  buffs: UserBuff.values.whereNot((el) => el == UserBuff.disciplined).toList(),
                  isSelected: (buff) => _buffs.contains(buff),
                  onSelected: (bool selected, buff) => _onBuffSelected(selected, buff),
                ),
              ],
            ),
          ),
          Padding(
            padding: horizontalPadding16,
            child: ExpansionTile(
              title: Text('Debuffs ${_debuffs.isNotEmpty ? '(${_debuffs.length})' : ''}'),
              children: [
                UserDebuffWrap(
                  debuffs: const [UserDebuff.fatigued, UserDebuff.coldMuscle],
                  isSelected: (debuff) => _debuffs.contains(debuff),
                  onSelected: (bool selected, debuff) => _onDebuffSelected(selected, debuff),
                ),
              ],
            ),
          ),
          verticalMargin16,
          Expanded(
            child: ScrollShadow(
              padding: horizontalPadding16 + bottomPadding16,
              child: ReorderableListView.builder(
                itemCount: _steps.length,
                onReorder: _onReorderSteps,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                footer: InkWell(
                  key: const ValueKey('add-step-tile'),
                  onTap: _addStep,
                  child: Padding(
                    padding: verticalPadding8,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Add step',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextTheme.of(context).titleMedium,
                          ),
                        ),
                        horizontalMargin16,
                        const Icon(Icons.add),
                      ],
                    ),
                  ),
                ),
                itemBuilder: (BuildContext context, int index) {
                  final step = _steps[index];
                  return Padding(
                    key: ValueKey(index),
                    padding: index < _steps.length ? bottomPadding16 : EdgeInsets.zero,
                    child: FocusBorder(
                      child: InkWell(
                        onTap: () => _editStep(index),
                        child: Padding(
                          padding: allPadding8,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  step.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextTheme.of(context).titleMedium,
                                ),
                              ),
                              horizontalMargin16,
                              Text('x${step.repeats + 1}'),
                              horizontalMargin16,
                              const Icon(Icons.menu),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: allPadding16,
            child: Row(
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
                    onTap: () => _submit(),
                    filled: true,
                    enabled: _createEnabled,
                    child: Text(widget.routine != null ? 'Update' : 'Create'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
