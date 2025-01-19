import 'package:flutter/material.dart';
import 'package:focus_flutter/app/layout.dart';

/// Step title and iteration.
@immutable
class StepTitleAndIteration extends StatelessWidget {
  /// Constructs a const [StepTitleAndIteration].
  const StepTitleAndIteration({
    super.key,
    required this.title,
    required this.iteration,
    required this.repeats,
  });

  /// Title.
  final String title;

  /// Iteration.
  final ValueNotifier<int> iteration;

  /// Repeats.
  final int repeats;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextTheme.of(context).titleMedium,
          textAlign: TextAlign.center,
        ),
        verticalMargin16,
        ValueListenableBuilder(
          valueListenable: iteration,
          builder: (BuildContext context, int value, Widget? child) {
            return Text(
              '${iteration.value + 1}/${repeats + 1}',
              style: TextTheme.of(context).titleMedium,
              textAlign: TextAlign.center,
            );
          },
        ),
      ],
    );
  }
}
