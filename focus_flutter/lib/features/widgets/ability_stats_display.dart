import 'package:flutter/material.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';

/// Displays [UserAbilityStats].
@immutable
class AbilityStatsDisplay extends StatelessWidget {
  /// Constructs a const [AbilityStatsDisplay].
  const AbilityStatsDisplay({
    super.key,
    required this.stats,
  });

  /// [UserAbilityStats] to display.
  final UserAbilityStats stats;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisExtent: 48.0,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
      ),
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        final ability = Ability.values[index];
        return Row(
          children: [
            Expanded(
              child: Text(
                ability.name.substring(0, 3).toUpperCase(),
              ),
            ),
            horizontalMargin8,
            Expanded(
              child: Text(
                stats.expFor(ability).toString(),
              ),
            ),
          ],
        );
      },
    );
  }
}
