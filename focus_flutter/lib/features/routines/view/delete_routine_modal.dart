import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/routines/repository/routines_repository.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/focus_choice_chip.dart';
import 'package:focus_flutter/features/widgets/loading_cover.dart';
import 'package:focus_flutter/features/widgets/scroll_shadow.dart';

/// Confirms deltion of a [Routine].
@immutable
class DeleteRoutineModal extends ConsumerWidget {
  /// Constructs a const [DeleteRoutineModal].
  const DeleteRoutineModal({
    super.key,
    required this.routine,
  });

  /// [Routine] in question.
  final Routine routine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = routine.steps.fold<UserAbilityStats>(
      UserAbilityStats(
        strengthExp: 0,
        vitalityExp: 0,
        agilityExp: 0,
        intelligenceExp: 0,
        perceptionExp: 0,
      ),
      (UserAbilityStats folded, RoutineStep step) => folded + step.abilityExpValues,
    );
    return LoadingCover(
      loading: ref.watch(routinesRepositoryProvider).isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalMargin16,
          Padding(
            padding: horizontalPadding16,
            child: Text(
              'Delete Routine?',
              textAlign: TextAlign.center,
              style: TextTheme.of(context).titleLarge,
            ),
          ),
          verticalMargin16,
          Padding(
            padding: horizontalPadding16,
            child: Text(
              routine.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ScrollShadow(
              padding: allPadding16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ExpansionTile(
                    title: Text(
                      'Buffs ${routine.buffs.length}',
                    ),
                    children: [
                      Wrap(
                        spacing: 4.0,
                        children: [
                          for (final buff in routine.buffs) //
                            FocusChoiceChip(
                              label: buff.name,
                              selected: true,
                              selectedColor: buff.color,
                              onSelected: (bool selected) {},
                            ),
                        ],
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Debuffs ${routine.debuffs.length}',
                    ),
                    children: [
                      Wrap(
                        spacing: 4.0,
                        children: [
                          for (final debuff in routine.debuffs) //
                            FocusChoiceChip(
                              label: debuff.name,
                              selected: true,
                              selectedColor: debuff.color,
                              onSelected: (bool selected) {},
                            ),
                        ],
                      ),
                    ],
                  ),
                  verticalMargin16,
                  GridView.builder(
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
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: allPadding16,
            child: Row(
              children: [
                Expanded(
                  child: FocusButton(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ),
                horizontalMargin16,
                Expanded(
                  child: FocusButton(
                    onTap: () async {
                      await ref
                          .read(routinesRepositoryProvider.notifier)
                          .deleteRoutine(routine.id!);
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    filled: true,
                    child: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
