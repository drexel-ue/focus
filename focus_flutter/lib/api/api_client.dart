import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/app_environment.dart';
import 'package:focus_flutter/features/auth/repository/auth_repository.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

/// Method ran by [Client].
typedef ClientMethod<T> = Future<T> Function(Client client);

/// A mixin that provides access to the [Api] instance.
mixin ApiClientRef<T> on AsyncNotifier<T> {
  /// The [Api] instance.
  Client get api => ref.read(apiClientProvider);

  /// Will run [method] and retry after refreshing [AuthSession] if needed.
  Future<M?> refreshIfNeeded<M>(ClientMethod<M> method) async {
    try {
      return await method(api);
    } on ExpiredJWTException catch (_) {
      final currentAuthToken = ref.read(authRepositoryProvider).requireValue.token!;
      await api.authenticationKeyManager!.put(currentAuthToken.refreshToken);
      final newSession = await api.auth.refresh(currentAuthToken);
      ref.read(authRepositoryProvider.notifier).session = newSession;
      await api.authenticationKeyManager!.put(newSession.token!.accessToken);
      return await method(api);
    } on TokenMismatchException catch (_) {
      await ref.read(authRepositoryProvider.notifier).logout();
      return null;
    } catch (_, __) {
      return null;
    }
  }
}

/// Provides access to the Serverpod RPC client.
final apiClientProvider = Provider<Client>((ref) {
  final host = ref.read(appEnvironmentProvider).host;
  return Client(
    host,
    authenticationKeyManager: _AuthKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();
});

class _AuthKeyManager extends AuthenticationKeyManager {
  String? _key;

  @override
  Future<String?> get() async => _key;

  @override
  Future<void> put(String key) async => _key = key;

  @override
  Future<void> remove() async => _key = null;
}
