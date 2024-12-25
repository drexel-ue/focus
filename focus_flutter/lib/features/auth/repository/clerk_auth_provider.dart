import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_flutter/app/app_environment.dart';

/// A mixin that provides access to the [Api] instance.
mixin ClerkAuthProviderRef<T> on AsyncNotifier<T> {
  /// The [Api] instance.
  Future<ClerkAuthProvider> get clerkAuthProvider => ref.read(clerkAuthProviderProvider.future);
}

/// Provides access to the [ClerkAuthProvider].
final clerkAuthProviderProvider = FutureProvider<ClerkAuthProvider>((ref) async {
  final appEnvironment = ref.read(appEnvironmentProvider);
  return ClerkAuthProvider.create(publishableKey: appEnvironment.clerkPublishableKey);
});
