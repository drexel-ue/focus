import 'package:flutter/foundation.dart';
import 'package:focus_client/focus_client.dart';

const _keyAuthSession = 'authSession';
const _keySelectedModel = 'selectedModel';

/// Data persisted to disk.
@immutable
class PersistedData {
  /// Constructs a const [PersistedData].
  const PersistedData({
    AuthSession? authSession,
  }) : _authSession = authSession;

  /// Creates a new [PersistedData] while preserving data.
  factory PersistedData.fromJson(Map<String, dynamic> jsonSerialization) {
    return PersistedData(
      authSession: jsonSerialization[_keyAuthSession] == null
          ? null
          : AuthSession.fromJson(jsonSerialization[_keyAuthSession]),
    );
  }

  /// [AuthSession].
  final AuthSession? _authSession;

  /// [AuthSession].
  AuthSession? get authSession => _authSession;

  /// Creates a new [PersistedData] while preserving data.
  PersistedData copyWith({
    AuthSession? authSession,
  }) {
    return PersistedData(
      authSession: authSession ?? _authSession,
    );
  }

  /// Creates a new [PersistedData] while preserving data.
  PersistedData copyWithout({
    bool authSession = false,
  }) {
    return PersistedData(
      authSession: authSession ? null : _authSession,
    );
  }

  /// Returns JSON serialization of [PersistedData].
  Map<String, dynamic> toJson() {
    return {
      if (_authSession != null) _keyAuthSession: _authSession.toJson(),
    };
  }
}
