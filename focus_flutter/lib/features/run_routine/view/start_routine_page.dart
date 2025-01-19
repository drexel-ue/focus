import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/run_routine/repository/run_routine_repository.dart';
import 'package:focus_flutter/features/run_routine/view/abort_routine_modal.dart';
import 'package:focus_flutter/features/widgets/ability_stats_display.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/focus_checkbox.dart';
import 'package:focus_flutter/features/widgets/scroll_shadow.dart';
import 'package:focus_flutter/features/widgets/user_buff_wrap.dart';
import 'package:focus_flutter/features/widgets/user_debuff_wrap.dart';

/// Start Routine Page.
@immutable
class StartRoutinePage extends ConsumerStatefulWidget {
  /// Constructs a const [StartRoutinePage].
  const StartRoutinePage({
    super.key,
    required this.onStart,
  });

  /// Calllback to start the [Routine].
  final VoidCallback onStart;

  @override
  ConsumerState<StartRoutinePage> createState() => _StartRoutinePageState();
}

class _StartRoutinePageState extends ConsumerState<StartRoutinePage> {
  final _withTimer = ValueNotifier<bool>(false);
  final _baseUnit = ValueNotifier<BaseUnit>(BaseUnit.second);
  final _duration = ValueNotifier<Duration>(Duration.zero);

  void _start() {
    if (_withTimer.value) {
      ref.read(runRoutineRepositoryProvider.notifier).restDuration = _duration.value;
    }
    widget.onStart();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(runRoutineRepositoryProvider).requireValue;
    final routine = state.routine;
    if (routine == null) {
      return emptyWidget;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        verticalMargin16,
        Padding(
          padding: horizontalPadding16,
          child: Text(
            'Routine: ${routine.title}',
            style: TextTheme.of(context).titleMedium,
          ),
        ),
        verticalMargin16,
        Expanded(
          child: ScrollShadow(
            padding: horizontalPadding16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ExpansionTile(
                  title: const Text('Rewards'),
                  children: [
                    AbilityStatsDisplay(stats: routine.stats),
                    verticalMargin16,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: UserBuffWrap(
                        buffs: routine.buffs,
                        isSelected: (buff) => true,
                        onSelected: (bool selected, buff) {},
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Punishments'),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: UserDebuffWrap(
                        debuffs: routine.debuffs,
                        isSelected: (debuff) => true,
                        onSelected: (bool selected, debuff) {},
                      ),
                    ),
                  ],
                ),
                verticalMargin16,
                ValueListenableBuilder(
                  valueListenable: _withTimer,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            FocusCheckbox(
                              selected: _withTimer.value,
                              onTap: () => _withTimer.value = !_withTimer.value,
                            ),
                            const Expanded(
                              child: Text('Rest'),
                            ),
                          ],
                        ),
                        if (_withTimer.value) ...[
                          verticalMargin16,
                          ValueListenableBuilder(
                            valueListenable: _baseUnit,
                            builder: (BuildContext context, BaseUnit value, Widget? child) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SegmentedButton<BaseUnit>(
                                    showSelectedIcon: false,
                                    selected: {_baseUnit.value},
                                    segments: [
                                      for (final unit in [
                                        BaseUnit.second,
                                        BaseUnit.minute,
                                        BaseUnit.hour
                                      ]) //
                                        ButtonSegment(
                                          value: unit,
                                          label: Text(
                                            unit.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                    ],
                                    onSelectionChanged: (values) => _baseUnit.value = values.first,
                                  ),
                                  verticalMargin16,
                                  ValueListenableBuilder(
                                    valueListenable: _duration,
                                    builder: (BuildContext context, Duration value, Widget? child) {
                                      return DurationPicker(
                                        duration: _duration.value,
                                        baseUnit: _baseUnit.value,
                                        onChange: (Duration duration) => _duration.value = duration,
                                      );
                                    },
                                  ),
                                  verticalMargin16,
                                ],
                              );
                            },
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: allPadding16 - topPadding16,
          child: Row(
            children: [
              Expanded(
                child: FocusButton(
                  onTap: () => AbortRoutineModal.show(context, ref),
                  child: const Text('Abort'),
                ),
              ),
              horizontalMargin16,
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: _withTimer,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return ValueListenableBuilder(
                      valueListenable: _duration,
                      builder: (BuildContext context, Duration value, Widget? child) {
                        return FocusButton(
                          onTap: () => _start(),
                          enabled: _withTimer.value ? _duration.value > Duration.zero : true,
                          filled: true,
                          child: const Text('Start'),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
