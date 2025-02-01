import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/features/llm/repository/loaded_models.dart';
import 'package:focus_flutter/features/persistence/repository/persisted_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'package:focus_flutter/features/persistence/repository/persisted_data.dart';

/// A mixin that provides access to the [PersistenceRepository] instance.
mixin PersistenceRepoRef<T> on AsyncNotifier<T> {
  /// [PersistenceRepository].
  PersistenceRepository get persistanceRepo => ref.read(persistenceRepositoryProvider);
}

/// Provides access to the [PersistenceRepository].
final persistenceRepositoryProvider = Provider<PersistenceRepository>((ref) {
  return PersistenceRepository();
});

/// Repository for persisting data.
class PersistenceRepository {
  PersistedData _persistedData = PersistedData();
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
      _persistedData = _persistedData.copyWithout(authSession: true);
    } else {
      _persistedData = _persistedData.copyWith(authSession: value);
    }
    _saveData();
  }

  /// Gets [AuthSession].
  AuthSession? get authSession => _persistedData.authSession;

  /// Returns whether the model has been loaded.
  bool get modelLoaded => _persistedData.selectedModelData.isLoaded;

  /// Gets the selected model data.
  ModelData get selectedModel => _persistedData.selectedModelData;

  /// Marks the selected model as loaded.
  void markAsLoaded() {
    _persistedData.markAsLoaded(_persistedData.model);
    _saveData();
  }

  /// Reset state.
  Future<void> logout() async {
    _saveTimer?.cancel();
    _persistedData = PersistedData();
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
