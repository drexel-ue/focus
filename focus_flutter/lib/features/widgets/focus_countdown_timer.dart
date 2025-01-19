import 'dart:async';

import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/widgets.dart';

/// Focus themed countdown timer.
@immutable
class FocusCountdownTimer extends StatefulWidget {
  /// Constructs a const [FocusCountdownTimer].
  const FocusCountdownTimer({
    super.key,
    required this.duration,
    this.onFinished,
  });

  /// Duration of timer.
  final Duration duration;

  /// Callback to run when timer is finished.
  final VoidCallback? onFinished;

  @override
  State<FocusCountdownTimer> createState() => _FocusCountdownTimerState();
}

class _FocusCountdownTimerState extends State<FocusCountdownTimer> {
  late final Timer _timer;
  late final _secondsRemaining = ValueNotifier<int>(widget.duration.inSeconds);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsRemaining.value > 0) {
        _secondsRemaining.value -= 1;
      } else {
        _timer.cancel();
        widget.onFinished?.call();
      }
    });
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _secondsRemaining,
      builder: (BuildContext context, int value, Widget? child) {
        final baseUnit = value < 60
            ? BaseUnit.second
            : value < 3600
                ? BaseUnit.minute
                : BaseUnit.hour;
        return DurationPicker(
          duration: Duration(seconds: value),
          baseUnit: baseUnit,
          onChange: (Duration duration) => {},
        );
      },
    );
  }
}
