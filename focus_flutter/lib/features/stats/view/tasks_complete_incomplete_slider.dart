import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/stats/repository/stats_repository.dart';
import 'package:focus_flutter/features/widgets/focus_border.dart';

/// Displays the percentages of completed and incomplete tasks on a slider.
@immutable
class TasksCompleteIncompleteSlider extends ConsumerStatefulWidget {
  /// Constructs a const [TasksCompleteIncompleteSlider].
  const TasksCompleteIncompleteSlider({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CompleteIncompleteSliderState();
}

class _CompleteIncompleteSliderState extends ConsumerState<TasksCompleteIncompleteSlider>
    with SingleTickerProviderStateMixin {
  static const _duration = Duration(milliseconds: 550);
  static const _thumbWidth = 6.0;
  static const _thumbHeight = 16.0;
  static const _thumbPadding = 4.0;

  late final AnimationController _controller;
  final _valueNotifier = ValueNotifier<double>(0.5);

  TaskStats get stats => ref.read(statsRepositoryProvider).requireValue.taskStats!;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration)
      ..addListener(_listener)
      ..forward();
  }

  void _listener() {
    final value = stats.completedTally / (stats.incompleteTally + stats.completedTally);
    _valueNotifier.value = Tween<double>(begin: 0.5, end: value)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
        .value;
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_listener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Tasks: Complete / Incomplete',
          textAlign: TextAlign.center,
        ),
        verticalMargin4,
        SizedBox(
          height: 16.0,
          child: Row(
            children: [
              Text('${stats.completedTally}'),
              horizontalMargin16,
              Expanded(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return ValueListenableBuilder<double>(
                      valueListenable: _valueNotifier,
                      builder: (BuildContext context, double value, Widget? child) {
                        final fullWidth = constraints.maxWidth - _thumbWidth - _thumbPadding * 2.0;
                        final leftBarWith = fullWidth * _valueNotifier.value;
                        final rightBarWith = fullWidth - leftBarWith;
                        return Row(
                          children: [
                            AnimatedContainer(
                              duration: _duration,
                              width: leftBarWith,
                              height: _thumbHeight / 2.0,
                              color: AppColors.white,
                            ),
                            const SizedBox(width: _thumbPadding),
                            const FocusBorder(
                              child: SizedBox(width: _thumbWidth, height: _thumbHeight),
                            ),
                            const SizedBox(width: _thumbPadding),
                            FocusBorder(
                              child: AnimatedContainer(
                                duration: _duration,
                                width: rightBarWith,
                                height: _thumbHeight / 2.0,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              horizontalMargin16,
              Text('${stats.incompleteTally}'),
            ],
          ),
        ),
      ],
    );
  }
}
