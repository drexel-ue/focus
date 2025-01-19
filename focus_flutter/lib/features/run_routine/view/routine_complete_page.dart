import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Routine complete page.
@immutable
class RoutineCompletePage extends ConsumerWidget {
  /// Constructs a const [RoutineCompletePage].
  const RoutineCompletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(child: Text('Routine complete'));
  }
}
