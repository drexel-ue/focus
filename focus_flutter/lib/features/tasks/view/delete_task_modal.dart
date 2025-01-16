import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/tasks/repository/tasks_repository.dart';
import 'package:focus_flutter/features/widgets/ability_stats_display.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/loading_cover.dart';

/// Confirms deltion of a [Task].
@immutable
class DeleteTaskModal extends ConsumerWidget {
  /// Constructs a const [DeleteTaskModal].
  const DeleteTaskModal({
    super.key,
    required this.task,
  });

  /// [Task] in question.
  final Task task;

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
            AbilityStatsDisplay(stats: task.abilityExpValues),
            spacer,
            Row(
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
                      await ref.read(taskRepositoryProvider.notifier).deleteTask(task.id!);
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
          ],
        ),
      ),
    );
  }
}
