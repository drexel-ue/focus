import 'package:flutter/material.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/features/stats/view/ablility_level_progress_tile.dart';

/// Animates the display of [AbilityLevelProgressTile]s.
@immutable
class AbilityLevelProgressTiles extends StatefulWidget {
  /// Constructs a const [AbilityLevelProgressTiles].
  const AbilityLevelProgressTiles({super.key});

  @override
  State<StatefulWidget> createState() => _AbilityLevelProgressTilesState();
}

class _AbilityLevelProgressTilesState extends State<AbilityLevelProgressTiles>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..forward();
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
        for (int index = 0; index < Ability.values.length; index++) //
          AblilityLevelProgressTile(
            ability: Ability.values[index],
            animation: CurvedAnimation(
              parent: _controller,
              curve: Interval(
                1 / Ability.values.length * index,
                1 / Ability.values.length * index + 1 / Ability.values.length,
                curve: Curves.easeInOut,
              ),
            ),
          ),
      ],
    );
  }
}
