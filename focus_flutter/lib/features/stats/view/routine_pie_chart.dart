import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';

/// Displays a pie chart of [Routine] stats.
@immutable
class RoutinePieChart extends ConsumerStatefulWidget {
  /// Constructs a const [RoutinePieChart].
  const RoutinePieChart({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoutinePieChartState();
}

class _RoutinePieChartState extends ConsumerState<RoutinePieChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Routines: Completed / Aborted / Timed Out',
          textAlign: TextAlign.center,
        ),
        verticalMargin8,
        SizedBox.square(
          dimension: 200.0,
          child: CustomPaint(
            painter: _PieChartPainter(
              completedRoutines: 10,
              abortedRoutines: 10,
              timedOutRoutines: 10,
              animation: _controller,
            ),
          ),
        ),
      ],
    );
  }
}

class _PieChartPainter extends CustomPainter {
  const _PieChartPainter({
    required this.completedRoutines,
    required this.abortedRoutines,
    required this.timedOutRoutines,
    required this.animation,
  });

  final int completedRoutines;
  final int abortedRoutines;
  final int timedOutRoutines;
  final Animation<double> animation;

  int get _total => completedRoutines + abortedRoutines + timedOutRoutines;
  double get _completed => completedRoutines / _total;
  double get _aborted => abortedRoutines / _total;
  double get _timedOut => timedOutRoutines / _total;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2.0, size.height / 2.0);
    final radius = math.min(size.width, size.height) / 2.0;
    const startAngle = 0.0 - math.pi / 2.0;
    const sweepAngle = 2 * math.pi;
    final outerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    // outer circle.
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      outerPaint,
    );
    // completed.
    final completedPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;
    final completedSweep = sweepAngle * _completed;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 4.0),
      startAngle,
      completedSweep,
      true,
      completedPaint,
    );
    // aborted.
    final abortedPaint = Paint()
      ..color = AppColors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;
    final abortedSweep = sweepAngle * _aborted;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 4.0),
      startAngle + completedSweep,
      abortedSweep,
      true,
      abortedPaint,
    );
    // timed out.
    final timedOutPaint = Paint()
      ..color = AppColors.dullGray
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;
    final timedOutSweep = sweepAngle * _timedOut;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 4.0),
      startAngle + completedSweep + abortedSweep,
      timedOutSweep,
      true,
      timedOutPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _PieChartPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value;
  }
}
