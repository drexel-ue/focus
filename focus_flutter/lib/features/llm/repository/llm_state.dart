import 'package:flutter/foundation.dart';

/// State of the [LLMRepository].
@immutable
class LLMState {
  /// Constructs a const [LLMState].
  const LLMState({
    this.loadingModel = false,
    this.modelLoadProgress = 0,
  });

  /// Is the model currently loading?
  final bool loadingModel;

  /// Progress of loading the model.
  final int modelLoadProgress;

  /// Creates a new [LLMState] while preserving data.
  LLMState copyWith({
    bool? loadingModel,
    int? modelLoadProgress,
  }) {
    return LLMState(
      loadingModel: loadingModel ?? this.loadingModel,
      modelLoadProgress: modelLoadProgress ?? this.modelLoadProgress,
    );
  }
}
