import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_flutter/app/assets.dart';
import 'package:focus_flutter/app/routing.dart';
import 'package:focus_flutter/features/auth/repository/auth_repository.dart';
import 'package:go_router/go_router.dart';

/// Auth Page.
@immutable
class AuthPage extends ConsumerWidget {
  /// Constructs a const [AuthPage].
  const AuthPage({super.key});

  /// Path.
  static const path = '/auth';

  /// [GoRoute].
  static GoRoute route = GoRoute(
    path: path,
    pageBuilder: defaultPageBuilder(const AuthPage()),
  );

  Future<void> _onSignInPressed(BuildContext context, WidgetRef ref) async {
    await ref.read(authRepositoryProvider.notifier).authenticate(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: InkWell(
        onTap: () => _onSignInPressed(context, ref),
        child: SvgPicture.asset(
          AppAssets.googleSignInIcon,
          height: 40.0,
          width: 40.0,
        ),
      ),
    );
  }
}
