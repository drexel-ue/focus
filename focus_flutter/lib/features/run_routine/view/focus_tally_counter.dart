import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';

/// Focus themed tally counter.
@immutable
class FocusTallyCounter extends StatefulWidget {
  /// Constructs a const [FocusTallyCounter].
  const FocusTallyCounter({
    super.key,
    required this.tally,
    required this.onChanged,
  });

  /// Tally.
  final int tally;

  /// Callback to run when tally is changed.
  final ValueChanged<int> onChanged;

  @override
  State<FocusTallyCounter> createState() => _FocusTallyCounterState();
}

class _FocusTallyCounterState extends State<FocusTallyCounter> {
  late final _tally = ValueNotifier(widget.tally);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder(
          valueListenable: _tally,
          builder: (BuildContext context, int value, Widget? child) {
            return AnimatedFlipCounter(
              value: _tally.value,
              textStyle: const TextStyle(fontSize: 72.0),
            );
          },
        ),
        verticalMargin16,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FocusButton(
              onTap: () {
                _tally.value = (_tally.value - 10).clamp(0, _tally.value);
                widget.onChanged(_tally.value);
              },
              square: true,
              child: const Text('-10'),
            ),
            FocusButton(
              onTap: () {
                _tally.value = (_tally.value - 1).clamp(0, _tally.value);
                widget.onChanged(_tally.value);
              },
              square: true,
              child: const Text('-1'),
            ),
            FocusButton(
              onTap: () {
                _tally.value = 0;
                widget.onChanged(_tally.value);
              },
              square: true,
              child: const Text('0'),
            ),
            FocusButton(
              onTap: () {
                _tally.value = _tally.value + 1;
                widget.onChanged(_tally.value);
              },
              square: true,
              child: const Text('+1'),
            ),
            FocusButton(
              onTap: () {
                _tally.value = _tally.value + 10;
                widget.onChanged(_tally.value);
              },
              square: true,
              child: const Text('+10'),
            ),
          ],
        ),
      ],
    );
  }
}
