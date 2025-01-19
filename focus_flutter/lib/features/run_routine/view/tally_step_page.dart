import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';

/// Tally step page.
@immutable
class TallyStepPage extends ConsumerStatefulWidget {
  /// Constructs a const [TallyStepPage].
  const TallyStepPage({
    super.key,
    required this.step,
    required this.onComplete,
  });

  /// [RoutineStep].
  final RoutineStep step;

  /// Callback to run when tally step is completed.
  final VoidCallback onComplete;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TallyStepPageState();
}

class _TallyStepPageState extends ConsumerState<TallyStepPage> {
  int _iteration = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.step.title),
    );
  }
}
