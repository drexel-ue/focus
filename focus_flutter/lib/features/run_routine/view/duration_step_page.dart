import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';

/// Duration step page.
@immutable
class DurationStepPage extends ConsumerStatefulWidget {
  /// Constructs a const [DurationStepPage].
  const DurationStepPage({
    super.key,
    required this.step,
  });

  /// [RoutineStep].
  final RoutineStep step;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DurationStepPageState();
}

class _DurationStepPageState extends ConsumerState<DurationStepPage> {
  int _iteration = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.step.title),
    );
  }
}
