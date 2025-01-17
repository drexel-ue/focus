import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:focus_client/focus_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

const _keyAuthSession = 'authSession';
const _keyCurrentStep = 'currentStep';

/// A mixin that provides access to the [PersistenceRepository] instance.
mixin PersistenceRepoRef<T> on AsyncNotifier<T> {
  /// [PersistenceRepository].
  PersistenceRepository get persistanceRepo => ref.read(persistenceRepositoryProvider);
}

/// Provides access to the [PersistenceRepository].
final persistenceRepositoryProvider = Provider<PersistenceRepository>((ref) {
  return PersistenceRepository();
});

/// Data persisted to disk.
@immutable
class PersistedData {
  /// Constructs a const [PersistedData].
  const PersistedData({
    AuthSession? authSession,
    int? currentStep,
  })  : _authSession = authSession,
        _currentStep = currentStep;

  /// Creates a new [PersistedData] while preserving data.
  factory PersistedData.fromJson(Map<String, dynamic> jsonSerialization) {
    return PersistedData(
      authSession: jsonSerialization[_keyAuthSession] == null
          ? null
          : AuthSession.fromJson(jsonSerialization[_keyAuthSession]),
      currentStep: jsonSerialization[_keyCurrentStep] as int?,
    );
  }

  /// [AuthSession].
  final AuthSession? _authSession;

  /// [AuthSession].
  AuthSession? get authSession => _authSession;

  /// Current [Routine] step.
  final int? _currentStep;

  /// Current [Routine] step.
  int? get currentStep => _currentStep;

  /// Creates a new [PersistedData] while preserving data.
  PersistedData copyWith({
    AuthSession? authSession,
    int? currentStep,
  }) {
    return PersistedData(
      authSession: authSession ?? _authSession,
      currentStep: currentStep ?? _currentStep,
    );
  }

  /// Returns JSON serialization of [PersistedData].
  Map<String, dynamic> toJson() {
    return {
      if (_authSession != null) _keyAuthSession: _authSession.toJson(),
      if (_currentStep != null) _keyCurrentStep: _currentStep,
    };
  }
}

/// Repository for persisting data.
class PersistenceRepository {
  PersistedData _persistedData = const PersistedData();
  late File _file;
  Timer? _saveTimer;

  /// Initializes [PersistedData] from disk.
  Future<void> initialize() async {
    final directory = await getApplicationDocumentsDirectory();
    _file = File('${directory.path}/persisted_data.json');
    if (await _file.exists()) {
      final content = await _file.readAsString();
      final jsonSerialization = json.decode(content);
      _persistedData = PersistedData.fromJson(jsonSerialization);
    } else {
      final jsonSerialization = json.encode(_persistedData.toJson());
      await _file.writeAsString(jsonSerialization);
    }
  }

  /// Sets [AuthSession].
  set authSession(AuthSession? value) {
    if (value == null) {
      _persistedData = PersistedData(currentStep: _persistedData.currentStep);
    } else {
      _persistedData = _persistedData.copyWith(authSession: value);
    }
    _saveData();
  }

  /// Gets [AuthSession].
  AuthSession? get authSession => _persistedData.authSession;

  /// Sets current [Routine] step.
  set currentStep(int? value) {
    if (value == null) {
      _persistedData = PersistedData(authSession: _persistedData.authSession);
    } else {
      _persistedData = _persistedData.copyWith(currentStep: value);
    }
    _saveData();
  }

  /// Gets current [Routine] step.
  int? get currentStep => _persistedData.currentStep;

  /// Reset state.
  Future<void> logout() async {
    _saveTimer?.cancel();
    _persistedData = const PersistedData();
    final jsonSerialization = json.encode(_persistedData.toJson());
    await _file.writeAsString(jsonSerialization);
  }

  Future<void> _saveData() async {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 400), () async {
      final jsonSerialization = json.encode(_persistedData.toJson());
      await _file.writeAsString(jsonSerialization);
    });
  }
}
