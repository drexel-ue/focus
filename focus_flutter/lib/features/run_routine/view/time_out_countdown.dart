import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/features/run_routine/repository/run_routine_repository.dart';

/// Time out countdown.
@immutable
class TimeOutCountdown extends ConsumerStatefulWidget {
  /// Constructs a const [TimeOutCountdown].
  const TimeOutCountdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimeOutCountdownState();
}

class _TimeOutCountdownState extends ConsumerState<TimeOutCountdown> {
  final _stopwatch = Stopwatch();
  late final Timer _timer;
  late final ValueNotifier<Duration> _timeRemaining;

  @override
  void initState() {
    super.initState();
    final record = ref.read(runRoutineRepositoryProvider).requireValue.record!;
    final deadline = record.createdAt.add(const Duration(hours: 24));
    _stopwatch.start();
    _timeRemaining = ValueNotifier<Duration>(deadline.difference(DateTime.timestamp()));
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        final timeRemaining = deadline.difference(DateTime.timestamp());
        if (timeRemaining.inSeconds <= 0) {
          _stopwatch.stop();
          _timer.cancel();
        } else {
          _timeRemaining.value = timeRemaining;
        }
      },
    );
  }

  @override
  void dispose() {
    _stopwatch.stop();
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Time remaining: '),
        ValueListenableBuilder(
          valueListenable: _timeRemaining,
          builder: (BuildContext context, Duration value, Widget? child) {
            final hours = _timeRemaining.value.inHours.toString().padLeft(2, '0');
            final minutes =
                (_timeRemaining.value.inMinutes).remainder(60).toString().padLeft(2, '0');
            final seconds =
                (_timeRemaining.value.inSeconds).remainder(60).toString().padLeft(2, '0');
            const allotedTime = Duration(hours: 24);

            return Text(
              '$hours:$minutes:$seconds',
              style: TextStyle(
                color: value.inSeconds < allotedTime.inSeconds / 4
                    ? AppColors.vibrantRed
                    : value.inSeconds < allotedTime.inSeconds / 2
                        ? AppColors.redOrange
                        : AppColors.white,
              ),
            );
          },
        ),
      ],
    );
  }
}
