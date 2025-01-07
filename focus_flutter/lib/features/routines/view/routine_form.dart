import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/routines/repository/routines_repository.dart';
import 'package:focus_flutter/features/widgets/focus_choice_chip.dart';
import 'package:focus_flutter/features/widgets/loading_cover.dart';

/// Form for creating/editing a [Routine].
@immutable
class RoutineForm extends ConsumerStatefulWidget {
  /// Constructs a const [RoutineForm].
  const RoutineForm({
    super.key,
    required this.close,
    this.routine,
  });

  /// Callback to call when cancelling.
  final VoidCallback close;

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
      child: Padding(
        padding: horizontalPadding16,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              verticalMargin16,
              TextField(
                controller: _titleController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
              verticalMargin16,
              Wrap(
                spacing: 4.0,
                children: [
                  for (final buff
                      in UserBuff.values.whereNot((el) => el == UserBuff.disciplined)) //
                    FocusChoiceChip(
                      label: buff.name,
                      selected: _buffs.contains(buff),
                      selectedColor: buff.color,
                      onSelected: (bool selected) => _onBuffSelected(selected, buff),
                    ),
                ],
              ),
              verticalMargin16,
              Wrap(
                spacing: 4.0,
                children: [
                  for (final debuff in [UserDebuff.fatigued, UserDebuff.coldMuscle]) //
                    FocusChoiceChip(
                      label: debuff.name,
                      selected: _debuffs.contains(debuff),
                      selectedColor: debuff.color,
                      onSelected: (bool selected) => _onDebuffSelected(selected, debuff),
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
