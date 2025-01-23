import 'package:flutter/material.dart';
import 'package:focus_client/focus_client.dart';

/// To be used to cover content in loading states.
@immutable
class LoadingCover extends StatelessWidget {
  /// Constructs a const [LoadingCover].
  const LoadingCover({
    super.key,
    required this.loading,
    required this.child,
  });

  /// Loading?
  final bool loading;

  /// Child.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (loading)
          Material(
            color: AppColors.white.withValues(alpha: 0.1),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
