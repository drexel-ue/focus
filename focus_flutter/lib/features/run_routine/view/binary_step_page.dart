import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';

/// Binary step page.
@immutable
class BinaryStepPage extends ConsumerStatefulWidget {
  /// Constructs a const [BinaryStepPage].
  const BinaryStepPage({
    super.key,
    required this.step,
    required this.onComplete,
  });

  /// [RoutineStep].
  final RoutineStep step;

  /// Callback to run when binary step is completed.
  final VoidCallback onComplete;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BinaryStepPageState();
}

class _BinaryStepPageState extends ConsumerState<BinaryStepPage> {
  int _iteration = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.step.title),
    );
  }
}
