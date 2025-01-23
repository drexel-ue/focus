import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/auth/repository/auth_repository.dart';
import 'package:focus_flutter/features/stats/view/ability_level_progress_tiles.dart';
import 'package:focus_flutter/features/stats/view/routine_stats_tile.dart';
import 'package:focus_flutter/features/stats/view/task_stats_tile.dart';
import 'package:focus_flutter/features/stats/view/user_avatar.dart';
import 'package:focus_flutter/features/widgets/buff_modal.dart';
import 'package:focus_flutter/features/widgets/debuff_modal.dart';
import 'package:focus_flutter/features/widgets/focus_choice_chip.dart';
import 'package:focus_flutter/features/widgets/scroll_shadow.dart';

/// Stats Page.
@immutable
class StatsPage extends ConsumerWidget {
  /// Construcs a const [StatsPage].
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).requireValue.user!;
    final modifiers = [...user.buffs, ...user.debuffs];
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
                    verticalMargin4,
                    SizedBox(
                      height: 40.0,
                      child: ScrollShadow(
                        axis: Axis.horizontal,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: modifiers.length,
                          itemBuilder: (BuildContext context, int index) {
                            final modifier = modifiers[index];
                            return Padding(
                              padding: index < modifiers.length - 1 //
                                  ? rightPadding8
                                  : EdgeInsets.zero,
                              child: FocusChoiceChip(
                                label: modifier is UserBuff
                                    ? modifier.name
                                    : (modifier as UserDebuff).name,
                                selected: true,
                                selectedColor: modifier is UserBuff
                                    ? modifier.color
                                    : (modifier as UserDebuff).color,
                                onLongPress: () {
                                  if (modifier is UserBuff) {
                                    BuffModal.show(context, modifier);
                                  }
                                  if (modifier is UserDebuff) {
                                    DebuffModal.show(context, modifier);
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
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
                verticalMargin16,
                RoutineStatsTile(),
                verticalMargin16,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
