import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/auth/repository/auth_repository.dart';
import 'package:focus_flutter/features/auth/view/auth_page.dart';
import 'package:focus_flutter/features/home/view/home_page.dart';
import 'package:go_router/go_router.dart';

/// Provides access to the [GoRouter].
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AuthPage.path,
    refreshListenable: ref.read(authRepositoryProvider.notifier),
    routes: [
      AuthPage.route,
      HomePage.route,
    ],
    redirect: (BuildContext context, GoRouterState state) async {
      final authenticated = (await ref.read(authRepositoryProvider.future)).authenticated;
      if (authenticated) {
        return HomePage.path;
      }
      return AuthPage.path;
    },
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
      return _PageAnimation(
        animation: animation,
        child: child,
      );
    },
  );
}

@immutable
class _PageAnimation extends StatefulWidget {
  const _PageAnimation({
    required this.animation,
    required this.child,
  });

  final Animation<double> animation;
  final Widget child;

  @override
  State<_PageAnimation> createState() => __PageAnimationState();
}

class __PageAnimationState extends State<_PageAnimation> {
  @override
  void initState() {
    super.initState();
    widget.animation.addListener(_listener);
  }

  void _listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: widget.animation.value,
      child: Padding(
        padding: allPadding16,
        child: widget.animation.isCompleted //
            ? widget.child
            : null,
      ),
    );
  }
}
