import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_flutter/features/auth/repository/auth_repository.dart';
import 'package:focus_flutter/features/widget/focus_button.dart';

/// Settings Page.
@immutable
class SettingsPage extends ConsumerWidget {
  /// Construcs a const [SettingsPage].
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SizedBox(
        width: 200.0,
        child: FocusButton(
          onTap: () => ref.read(authRepositoryProvider.notifier).logout(),
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
