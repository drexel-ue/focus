import 'dart:async';

import 'package:clerk_auth/clerk_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/api/api_client.dart';
import 'package:focus_flutter/features/auth/repository/clerk_auth_provider.dart';

/// Provides acccess to [AuthRepository].
final authRepositoryProvider = AsyncNotifierProvider<AuthRepository, AuthSession>(() {
  return AuthRepository();
});

/// Manages [AuthSession].
class AuthRepository extends AsyncNotifier<AuthSession>
    with ClerkAuthProviderRef, Logging, ApiClientRef, ChangeNotifier {
  @override
  set state(AsyncValue<AuthSession> value) {
    super.state = value;
    notifyListeners();
  }

  /// Requests a new [AuthSession].
  Future<void> authenticate(BuildContext context) async {
    Session? clerkSession;
    final clerkAuth = await clerkAuthProvider;
    await clerkAuth.signOut();
    try {
      state = const AsyncLoading<AuthSession>().copyWithPrevious(state);
      if (!context.mounted) {
        return;
      }
      await clerkAuth.sso(context, Strategy.oauthGoogle);
      if (clerkAuth.session case Session session when session.lastActiveToken != null) {
        clerkSession = session;
        await api.authenticationKeyManager!.put(session.lastActiveToken!.jwt);
        final authResponse = await api.auth.authenticate();
        await api.authenticationKeyManager!.put(authResponse.token!.accessToken);
        state = AsyncData(authResponse);
      } else {
        state = AsyncData(AuthSession());
      }
    } catch (error, stackTrace) {
      logSevere('error in _authenticate:\nerror: $error\nstackTrace: $stackTrace');
      if (clerkSession != null) {
        await clerkAuth.signOutOf(clerkSession);
      }
      state = AsyncError<AuthSession>(error, stackTrace).copyWithPrevious(state);
    }
  }

  @override
  FutureOr<AuthSession> build() {
    // FIXME(drexel-ul): restore session.
    return AuthSession();
  }
}
