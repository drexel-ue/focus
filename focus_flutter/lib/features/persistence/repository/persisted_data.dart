import 'package:flutter/foundation.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/features/llm/repository/llm_enum.dart';
import 'package:focus_flutter/features/llm/repository/loaded_models.dart';

const _keyAuthSession = 'authSession';
const _keySelectedModel = 'selectedModel';
const _keyModels = 'models';

/// Data persisted to disk.
@immutable
class PersistedData {
  /// Constructs a const [PersistedData].
  PersistedData({
    AuthSession? authSession,
    LLM model = LLM.deekseekR1,
    LoadedModels? models,
  })  : _authSession = authSession,
        _model = model,
        _models = models ?? LoadedModels();

  /// Creates a new [PersistedData] while preserving data.
  factory PersistedData.fromJson(Map<String, dynamic> jsonSerialization) {
    return PersistedData(
      authSession: jsonSerialization[_keyAuthSession] == null
          ? null
          : AuthSession.fromJson(jsonSerialization[_keyAuthSession]),
      model: jsonSerialization[_keySelectedModel] == null
          ? LLM.deekseekR1
          : LLM.fromJson(jsonSerialization[_keySelectedModel] as String),
      models: jsonSerialization[_keyModels] == null
          ? LoadedModels()
          : LoadedModels.fromJson(jsonSerialization[_keyModels]),
    );
  }

  /// [AuthSession].
  final AuthSession? _authSession;

  /// [AuthSession].
  AuthSession? get authSession => _authSession;

  /// Selected model.
  final LLM _model;

  /// Selected model.
  LLM get model => _model;

  /// Model data.
  final LoadedModels _models;

  /// Model data.
  LoadedModels get models => _models;

  /// Selected model data.
  ModelData get selectedModelData => _models[_model];

  /// Marks a [model] as loaded.
  void markAsLoaded(LLM model) {
    _models.markAsLoaded(model);
  }

  /// Marks a [model] as not loaded.
  void markAsNotLoaded(LLM model) {
    _models.markAsNotLoaded(model);
  }

  /// Creates a new [PersistedData] while preserving data.
  PersistedData copyWith({
    AuthSession? authSession,
    LLM? model,
    LoadedModels? models,
  }) {
    return PersistedData(
      authSession: authSession ?? _authSession,
      model: model ?? _model,
      models: models ?? _models,
    );
  }

  /// Creates a new [PersistedData] while preserving data.
  PersistedData copyWithout({
    bool authSession = false,
    bool models = false,
  }) {
    return PersistedData(
      authSession: authSession ? null : _authSession,
      model: model,
      models: models ? LoadedModels() : _models,
    );
  }

  /// Returns JSON serialization of [PersistedData].
  Map<String, dynamic> toJson() {
    return {
      if (_authSession != null) _keyAuthSession: _authSession.toJson(),
      _keySelectedModel: _model.name,
      _keyModels: _models.toJson(),
    };
  }
}
