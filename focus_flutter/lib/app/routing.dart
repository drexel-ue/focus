import 'package:flutter/foundation.dart';
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
