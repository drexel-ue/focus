import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides access to the [AppEnvironment].
final appEnvironmentProvider = Provider<AppEnvironment>((_) => AppEnvironment.fromDartDefine());

/// Environment variables.
@immutable
class AppEnvironment {
  const AppEnvironment._({required this.host});

  /// Parses environment variables into an [AppEnvironment] instance.
  factory AppEnvironment.fromDartDefine() {
    return const AppEnvironment._(
      host: String.fromEnvironment('HOST'),
    );
  }

  /// Host for connecting to the Serverpod RPC server.
  final String host;
}
