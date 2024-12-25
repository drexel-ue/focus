import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_flutter/features/auth/view/auth_page.dart';
import 'package:go_router/go_router.dart';

/// Provides access to the [GoRouter].
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AuthPage.path,
    routes: [
      AuthPage.route,
    ],
  );
});

/// Default page builder.
Page<T> Function(BuildContext context, GoRouterState state) defaultPageBuilder<T>(Widget child) {
  return (BuildContext context, GoRouterState state) {
    return _buildPageWithDefaultTransition(context, state, child);
  };
}

CustomTransitionPage<T> _buildPageWithDefaultTransition<T>(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<T>(
    child: child,
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
