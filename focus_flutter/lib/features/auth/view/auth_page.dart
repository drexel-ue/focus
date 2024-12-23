import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Auth Page.
@immutable
class AuthPage extends StatelessWidget {
  /// Constructs a const [AuthPage].
  const AuthPage({super.key});

  /// Path.
  static const path = '/auth';

  /// [GoRoute].
  static GoRoute route = GoRoute(
    path: path,
    builder: (BuildContext context, GoRouterState state) => const AuthPage(),
  );

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Auth Page'),
    );
  }
}
