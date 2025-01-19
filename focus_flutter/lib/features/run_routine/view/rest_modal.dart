import 'dart:async';

import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/focus_modal.dart';

/// Rest modal.
@immutable
class RestModal extends StatefulWidget {
  /// Constructs a const [RestModal].
  const RestModal({
    super.key,
    required this.duration,
    this.nextStep,
    required this.closeModal,
  });

  /// Shows a [RestModal].
  static Future<void> show(BuildContext context, String? nextStep) async {
    await FocusModal.show<void>(
      context,
      (BuildContext context, CloseModal closeModal) => RestModal(
        duration: const Duration(seconds: 30),
        nextStep: nextStep,
        closeModal: closeModal,
      ),
    );
  }

  /// Duration to rest.
  final Duration duration;

  /// Next step.
  final String? nextStep;

  /// Callback to close modal.
  final CloseModal closeModal;

  @override
  State<RestModal> createState() => _RestModalState();
}

class _RestModalState extends State<RestModal> {
  late final Timer _timer;
  final _stopwatch = Stopwatch();
  late final _secondsRemaining = ValueNotifier<int>(widget.duration.inSeconds);

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_stopwatch.elapsed < widget.duration) {
        _secondsRemaining.value -= 1;
      } else {
        _timer.cancel();
        widget.closeModal();
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
    return Padding(
      padding: allPadding16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Rest',
            textAlign: TextAlign.center,
            style: TextTheme.of(context).titleMedium,
          ),
          verticalMargin16,
          if (widget.nextStep case String nextStep) ...[
            Text(
              'Up next: $nextStep',
              textAlign: TextAlign.center,
            ),
            verticalMargin16,
          ],
          ValueListenableBuilder(
            valueListenable: _secondsRemaining,
            builder: (BuildContext context, int value, Widget? child) {
              final baseUnit = value < 60 ? BaseUnit.second : BaseUnit.minute;
              return DurationPicker(
                duration: Duration(seconds: value),
                baseUnit: baseUnit,
                onChange: (Duration duration) => {},
              );
            },
          ),
          verticalMargin16,
          FocusButton(
            onTap: () => widget.closeModal(),
            child: const Text('Skip'),
          ),
        ],
      ),
    );
  }
}
