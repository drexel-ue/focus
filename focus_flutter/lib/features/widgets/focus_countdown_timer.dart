import 'dart:async';

import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';

/// Focus themed countdown timer.
@immutable
class FocusCountdownTimer extends StatefulWidget {
  /// Constructs a const [FocusCountdownTimer].
  const FocusCountdownTimer({
    super.key,
    required this.duration,
    this.canPause = false,
    this.onFinished,
    this.onChange,
  });

  /// Duration of timer.
  final Duration duration;

  /// Can be paused?
  final bool canPause;

  /// Callback to run when timer is finished.
  final VoidCallback? onFinished;

  /// Callback to run when timer is changed.
  final ValueChanged<Duration>? onChange;

  @override
  State<FocusCountdownTimer> createState() => _FocusCountdownTimerState();
}

class _FocusCountdownTimerState extends State<FocusCountdownTimer> {
  late final Timer _timer;
  late final _secondsRemaining = ValueNotifier<int>(widget.duration.inSeconds);
  final _paused = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_paused.value) {
        return;
      }
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
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            DurationPicker(
              duration: Duration(seconds: value),
              baseUnit: baseUnit,
              height: 220.0,
              onChange: (Duration duration) {
                if (_paused.value) {
                  _secondsRemaining.value = duration.inSeconds;
                  widget.onChange?.call(duration);
                }
              },
            ),
            if (widget.canPause)
              ValueListenableBuilder(
                valueListenable: _paused,
                builder: (BuildContext context, bool value, Widget? child) {
                  return FocusButton(
                    onTap: () => _paused.value = !value,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: value
                          ? const Icon(Icons.play_arrow_outlined)
                          : const Icon(Icons.pause_outlined),
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
