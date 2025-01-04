import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/tasks/repository/tasks_repository.dart';
import 'package:focus_flutter/features/widget/focus_button.dart';
import 'package:focus_flutter/features/widget/loading_cover.dart';

/// Confirms deltion of a [Task].
@immutable
class DeleteTaskModal extends ConsumerWidget {
  /// Constructs a const [DeleteTaskModal].
  const DeleteTaskModal({
    super.key,
    required this.task,
    required this.close,
  });

  /// [Task] in question.
  final Task task;

  /// Callback when cancel is pressed.
  final VoidCallback close;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LoadingCover(
      loading: ref.watch(taskRepositoryProvider).isLoading,
      child: Padding(
        padding: allPadding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Delete Task?',
              textAlign: TextAlign.center,
              style: TextTheme.of(context).titleLarge,
            ),
            verticalMargin16,
            Text(
              task.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
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
                        task.abilityExpValues.expFor(ability).toString(),
                      ),
                    ),
                  ],
                );
              },
            ),
            spacer,
            Row(
              children: [
                Expanded(
                  child: FocusButton(
                    onTap: () => close(),
                    child: const Text('Cancel'),
                  ),
                ),
                horizontalMargin16,
                Expanded(
                  child: FocusButton(
                    onTap: () async {
                      await ref.read(taskRepositoryProvider.notifier).deleteTask(task.id!);
                      close();
                    },
                    filled: true,
                    child: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
