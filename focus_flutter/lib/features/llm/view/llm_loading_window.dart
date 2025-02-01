import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/llm/repository/gemma_repository.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/focus_window.dart';

/// LLM loading window.
@immutable
class LLMLoadingWindow extends ConsumerStatefulWidget {
  /// Constructs a const [LLMLoadingWindow].
  const LLMLoadingWindow._({
    required this.closeWindow,
  });

  /// Shows a [LLMLoadingWindow].
  static Future<void> show(BuildContext context) async {
    return await FocusWindow.show(
      context,
      (BuildContext context, CloseWindow closeWindow) => LLMLoadingWindow._(
        closeWindow: closeWindow,
      ),
      barrierDismissible: false,
    );
  }

  /// Close window.
  final CloseWindow closeWindow;

  @override
  ConsumerState<LLMLoadingWindow> createState() => _LLMLoadingWindowState();
}

class _LLMLoadingWindowState extends ConsumerState<LLMLoadingWindow> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gemmaRepositoryProvider.notifier).loadLLM();
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(gemmaRepositoryProvider).requireValue.modelLoadProgress;
    final model = ref.watch(gemmaRepositoryProvider.notifier).selectedModel;
    return Padding(
      padding: allPadding16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Loading ${model.name} v${model.version}...',
            textAlign: TextAlign.center,
          ),
          verticalMargin8,
          const Text(
            'This may take a few minutes...',
            textAlign: TextAlign.center,
          ),
          verticalMargin8,
          const Text(
            'This model will be used to help you generate goals, complete tasks, and more.',
            textAlign: TextAlign.center,
          ),
          verticalMargin16,
          const Text(
            'You can change the model at any time in the settings.',
            textAlign: TextAlign.center,
          ),
          verticalMargin16,
          LinearProgressIndicator(
            value: progress / 100.0,
            backgroundColor: AppColors.black,
          ),
          verticalMargin16,
          FocusButton(
            onTap: () => widget.closeWindow(),
            filled: true,
            enabled: progress == 100,
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
