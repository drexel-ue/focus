import 'package:serverpod/server.dart';

/// Scoped defining access to various endpoints.
class CustomScope extends Scope {
  /// Constructs a const [CustomScope].
  const CustomScope(super.name);

  /// No access.
  static const none = CustomScope('none');

  /// May access [AuthEndpoint].
  static const auth = CustomScope('auth');

  /// May access [HomeEndpoint].
  static const home = CustomScope('home');

  /// All values.
  static const values = [
    none,
    auth,
    home,
  ];

  /// Parses [value] into a [CustomScope]. Will return [CustomScope.auth] by default.
  static CustomScope parse(String value) {
    return values.firstWhere(
      (CustomScope scope) => scope.name == value,
      orElse: () => none,
    );
  }
}