import 'package:flutter/material.dart';

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
          const Material(
            color: Colors.white10,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
