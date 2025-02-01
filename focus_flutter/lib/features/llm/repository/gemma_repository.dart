import 'dart:async';

import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:focus_flutter/features/llm/repository/loaded_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:focus_flutter/features/llm/repository/llm_repository.dart';

export 'package:focus_flutter/features/llm/repository/llm_state.dart';

/// A mixin that provides access to the [LLMRepository] instance.
mixin LLMRepoRef<T> on AsyncNotifier<T> {
  /// [LLMRepository].
  LLMRepository get llmRepo => ref.read(gemmaRepositoryProvider.notifier);
}

/// Provides access to the [GemmaRepository].
final gemmaRepositoryProvider = AsyncNotifierProvider<GemmaRepository, LLMState>(() {
  return GemmaRepository();
});

/// Implementation of [LLMRepository] using flutter_gemma package.
class GemmaRepository extends LLMRepository {
  /// Is the model loaded?
  bool get modelLoaded => persistanceRepo.modelLoaded;

  /// Selected model.
  ModelData get selectedModel => persistanceRepo.selectedModel;

  @override
  Future<void> loadLLM() async {
    try {
      if (persistanceRepo.modelLoaded) {
        return;
      }
      FlutterGemmaPlugin //
          .instance
          .loadNetworkModelWithProgress(url: persistanceRepo.selectedModel.url)
          .listen(
        (int progress) {
          state = AsyncData(state.requireValue.copyWith(
            modelLoadProgress: progress,
            loadingModel: true,
          ));
        },
        onDone: () {
          persistanceRepo.markAsLoaded();
          state = AsyncData(state.requireValue.copyWith(
            loadingModel: false,
          ));
        },
        onError: (error, stackTrace) {
          logSevere('error in loadNetworkModelWithProgress', error, stackTrace);
          state = AsyncError<LLMState>(error, stackTrace).copyWithPrevious(state);
        },
      );
    } catch (error, stackTrace) {
      logSevere('error in loadLLM', error, stackTrace);
      state = AsyncError<LLMState>(error, stackTrace).copyWithPrevious(state);
    }
  }

  @override
  FutureOr<LLMState> build() async => const LLMState();
}
