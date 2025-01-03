import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:clerk_auth/clerk_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/api/api_client.dart';
import 'package:focus_flutter/features/auth/repository/clerk_auth_provider.dart';
import 'package:focus_flutter/features/home/repository/home_repository.dart';
import 'package:focus_flutter/features/tasks/repository/tasks_repository.dart';
import 'package:path_provider/path_provider.dart';

/// Provides acccess to [AuthRepository].
final authRepositoryProvider = AsyncNotifierProvider<AuthRepository, AuthSession>(() {
  return AuthRepository();
});

/// Manages [AuthSession].
class AuthRepository extends AsyncNotifier<AuthSession>
    with ClerkAuthProviderRef, Logging, ApiClientRef, ChangeNotifier {
  late File _file;

  @override
  set state(AsyncValue<AuthSession> value) {
    super.state = value;
    notifyListeners();
  }

  set session(AuthSession session) => state = AsyncData(session);

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
        await _storeAuthSession();
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
      if (await _file.exists()) {
        await _file.delete();
      }
      state = AsyncData(AuthSession());
      ref.read(homeRepositoryProvider.notifier).logout();
      ref.read(taskRepositoryProvider.notifier).logout();
      api.authenticationKeyManager!.remove();
    } catch (error, stackTrace) {
      logSevere('error in logout', error, stackTrace);
      state = AsyncData(AuthSession());
      api.authenticationKeyManager!.remove();
    }
  }

  Future<AuthSession> _maybeRestoreSession() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      _file = File('${directory.path}/auth_key_store.json');
      if (await _file.exists()) {
        final content = await _file.readAsString();
        final jsonSerialization = json.decode(content);
        final session = AuthSession.fromJson(jsonSerialization);
        api.authenticationKeyManager!.put(session.token!.accessToken);
        return session;
      } else {
        final jsonSerialization = json.encode(AuthSession().toJson());
        await _file.writeAsString(jsonSerialization);
        return AuthSession();
      }
    } catch (error, stackTrace) {
      logSevere('error in _maybeRestoreSession', error, stackTrace);
      if (await _file.exists()) {
        await _file.delete();
      }
      return AuthSession();
    }
  }

  Future<void> _storeAuthSession() async {
    final jsonSerialization = json.encode(state.requireValue.toJson());
    await _file.writeAsString(jsonSerialization);
  }

  @override
  FutureOr<AuthSession> build() async => _maybeRestoreSession();
}
