import 'package:clerk_flutter/logging.dart';
import 'package:focus_flutter/features/llm/repository/llm_state.dart';
import 'package:focus_flutter/features/persistence/repository/persistence_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'package:focus_flutter/features/llm/repository/llm_state.dart';

/// Manages the LLM.
abstract class LLMRepository extends AsyncNotifier<LLMState> with Logging, PersistenceRepoRef {
  /// Loads LLM if needed.
  Future<void> loadLLM();
}
