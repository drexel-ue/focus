import 'dart:collection';

import 'package:focus_flutter/features/llm/repository/llm_enum.dart';

/// Loaded models.
class LoadedModels extends UnmodifiableMapBase<LLM, ModelData> {
  /// Constructs a const [LoadedModels].
  LoadedModels([Map<LLM, ModelData>? models]) : _models = models ?? _defaults;

  static final _defaults = <LLM, ModelData>{
    LLM.deekseekR1: const ModelData(
      name: 'deepseek-r1-distill-qwen-1.5b',
      url:
          'https://www.kaggle.com/api/v1/models/deepseek-ai/deepseek-r1/transformers/deepseek-r1-distill-qwen-1.5b/1/download',
      version: '1',
    ),
  };

  /// Deserializes [LoadedModels] from [jsonSerialization].
  factory LoadedModels.fromJson(Map<String, dynamic> jsonSerialization) {
    final models = <LLM, ModelData>{};
    for (final entry in jsonSerialization.entries) {
      models[LLM.fromJson(entry.key)] = ModelData.fromJson(entry.value);
    }
    return LoadedModels(models);
  }

  final Map<LLM, ModelData> _models;

  @override
  ModelData operator [](Object? key) {
    if (key is LLM) {
      return _models[key]!;
    }
    throw ArgumentError('Invalid key: $key');
  }

  @override
  Iterable<LLM> get keys => LLM.values;

  /// Marks a [model] as loaded.
  void markAsLoaded(LLM model) {
    _models[model] = _models[model]!.copyWith(isLoaded: true);
  }

  /// Marks a [model] as not loaded.
  void markAsNotLoaded(LLM model) {
    _models[model] = _models[model]!.copyWith(isLoaded: false);
  }

  /// Returns JSON serialization of [LoadedModels].
  Map<String, dynamic> toJson() {
    return {
      for (final entry in _models.entries) //
        entry.key.name: entry.value.toJson(),
    };
  }
}

/// Model data.
class ModelData {
  /// Constructs a const [ModelData].
  const ModelData({
    required this.name,
    required this.url,
    required this.version,
    this.isLoaded = false,
  });

  static const _name = 'name';
  static const _url = 'url';
  static const _version = 'version';
  static const _isLoaded = 'isLoaded';

  /// Deserializes [ModelData] from [jsonSerialization].
  factory ModelData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ModelData(
      name: jsonSerialization[_name] as String,
      url: jsonSerialization[_url] as String,
      version: jsonSerialization[_version] as String,
      isLoaded: jsonSerialization[_isLoaded] as bool,
    );
  }

  /// Model name.
  final String name;

  /// Download url.
  final String url;

  /// Model version.
  final String version;

  /// Is the model loaded?
  final bool isLoaded;

  /// Creates a new [ModelData] while preserving data.
  ModelData copyWith({
    String? name,
    String? url,
    String? version,
    bool? isLoaded,
  }) {
    return ModelData(
      name: name ?? this.name,
      url: url ?? this.url,
      version: version ?? this.version,
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }

  /// Returns JSON serialization of [ModelData].
  Map<String, dynamic> toJson() {
    return {
      _name: name,
      _url: url,
      _version: version,
      _isLoaded: isLoaded,
    };
  }
}
