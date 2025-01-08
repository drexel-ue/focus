import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/auth/repository/auth_repository.dart';

/// Displays the current level and progress toward the next for an [Ability].
@immutable
class AblilityLevelProgressTile extends ConsumerWidget {
  /// Constructs a const [AbilityLevelProgressTile].
  const AblilityLevelProgressTile({
    super.key,
    required this.ability,
    required this.animation,
  });

  /// [Ability] being tracked.
  final Ability ability;

  /// For animating the progress bar.
  final Animation<double> animation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).requireValue.user!;
    final levelWithRemainder = user.abilityStats.levelWithRemainderFor(ability);
    return Row(
      children: [
        SizedBox(
          width: 64.0 + 16.0,
          child: Text(ability.name.substring(0, 3).toUpperCase()),
        ),
        Text('${levelWithRemainder.level}'),
        horizontalMargin8,
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizeTransition(
              axis: Axis.horizontal,
              sizeFactor: animation,
              child: FractionallySizedBox(
                widthFactor: levelWithRemainder.remainder,
                child: const SizedBox(
                  height: 8.0,
                  child: ColoredBox(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        horizontalMargin8,
        Text('${levelWithRemainder.level + 1}')
      ],
    );
  }
}
