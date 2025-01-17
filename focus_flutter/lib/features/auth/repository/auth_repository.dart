import 'dart:async';
import 'package:clerk_auth/clerk_auth.dart' hide User;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/api/api_client.dart';
import 'package:focus_flutter/app/persistence.dart';
import 'package:focus_flutter/features/auth/repository/clerk_auth_provider.dart';
import 'package:focus_flutter/features/home/repository/home_repository.dart';
import 'package:focus_flutter/features/tasks/repository/tasks_repository.dart';

/// A mixin that provides access to the [AuthRepository] instance.
mixin AuthRepoRef<T> on AsyncNotifier<T> {
  /// [AuthRepository].
  AuthRepository get authRepo => ref.read(authRepositoryProvider.notifier);
}

/// Provides acccess to [AuthRepository].
final authRepositoryProvider = AsyncNotifierProvider<AuthRepository, AuthSession>(() {
  return AuthRepository();
});

/// Manages [AuthSession].
class AuthRepository extends AsyncNotifier<AuthSession>
    with ClerkAuthProviderRef, Logging, ApiClientRef, ChangeNotifier, PersistenceRepoRef {
  @override
  set state(AsyncValue<AuthSession> value) {
    super.state = value;
    persistanceRepo.authSession = state.requireValue;
    notifyListeners();
  }

  set session(AuthSession session) => state = AsyncData(session);

  set user(User value) => state = AsyncData(state.requireValue.copyWith(user: value));

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
      logSevere('error in authenticate:\nerror: $error\nstackTrace: $stackTrace');
      if (clerkSession != null) {
        await clerkAuth.signOutOf(clerkSession);
      }
      state = AsyncError<AuthSession>(error, stackTrace).copyWithPrevious(state);
    }
  }

  /// Remove stored [AuthSession].
  Future<void> logout() async {
    try {
      state = AsyncData(AuthSession());
      ref.read(homeRepositoryProvider.notifier).logout();
      ref.read(taskRepositoryProvider.notifier).logout();
      api.authenticationKeyManager!.remove();
      persistanceRepo.logout();
    } catch (error, stackTrace) {
      logSevere('error in logout', error, stackTrace);
      state = AsyncData(AuthSession());
      api.authenticationKeyManager!.remove();
    }
  }

  Future<AuthSession> _maybeRestoreSession() async {
    try {
      final session = persistanceRepo.authSession;
      if (session != null) {
        api.authenticationKeyManager!.put(session.token!.accessToken);
        return session;
      }
      return AuthSession();
    } catch (error, stackTrace) {
      logSevere('error in _maybeRestoreSession', error, stackTrace);
      return AuthSession();
    }
  }

  @override
  FutureOr<AuthSession> build() async => _maybeRestoreSession();
}
