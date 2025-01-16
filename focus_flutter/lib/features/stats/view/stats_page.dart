import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/auth/repository/auth_repository.dart';
import 'package:focus_flutter/features/stats/view/ability_level_progress_tiles.dart';
import 'package:focus_flutter/features/stats/view/task_stats_tile.dart';
import 'package:focus_flutter/features/stats/view/user_avatar.dart';
import 'package:focus_flutter/features/widgets/scroll_shadow.dart';

/// Stats Page.
@immutable
class StatsPage extends ConsumerWidget {
  /// Construcs a const [StatsPage].
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).requireValue.user!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        verticalMargin16,
        Padding(
          padding: horizontalPadding16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserAvatar(),
              horizontalMargin16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(user.fullName),
                    Text('Lv. ${user.abilityStats.userLevel}'),
                  ],
                ),
              ),
            ],
          ),
        ),
        verticalMargin16,
        const Expanded(
          child: ScrollShadow(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: horizontalPadding16,
                  child: AbilityLevelProgressTiles(),
                ),
                verticalMargin16,
                TaskStatsTile(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
