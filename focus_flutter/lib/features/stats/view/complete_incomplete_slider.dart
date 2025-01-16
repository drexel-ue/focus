import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/stats/repository/stats_repository.dart';

/// Displays the percentages of completed and incomplete tasks on a slider.
@immutable
class CompleteIncompleteSlider extends ConsumerStatefulWidget {
  /// Constructs a const [CompleteIncompleteSlider].
  const CompleteIncompleteSlider({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CompleteIncompleteSliderState();
}

class _CompleteIncompleteSliderState extends ConsumerState<CompleteIncompleteSlider>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))
      ..addListener(_listener)
      ..forward();
  }

  void _listener() => setState(() {});

  @override
  void dispose() {
    _controller
      ..removeListener(_listener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stats = ref.watch(statsRepositoryProvider).requireValue.taskStats!;
    final value = stats.completedTally / (stats.incompleteTally + stats.completedTally);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Tasks: Complete / Incomplete',
          textAlign: TextAlign.center,
        ),
        Row(
          children: [
            Text('${stats.completedTally}'),
            horizontalMargin16,
            Expanded(
              child: SizedBox(
                height: 16.0,
                child: Slider(
                  value: Tween<double>(begin: 0.5, end: value)
                      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
                      .value,
                  onChanged: (_) {},
                ),
              ),
            ),
            horizontalMargin16,
            Text('${stats.incompleteTally}'),
          ],
        ),
      ],
    );
  }
}
