import 'package:flutter/material.dart';
import 'package:focus_flutter/app/layout.dart';

/// Focus themed modal.
@immutable
class FocusModal extends StatelessWidget {
  const FocusModal._({
    required this.readyToRender,
    required this.builder,
  });

  /// Modal animation complete. Render.
  final bool readyToRender;

  /// Content builder.
  final WidgetBuilder builder;

  /// Show the modal.
  static Future<T?> show<T>(BuildContext context, WidgetBuilder builder) async {
    return await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 550),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return FocusModal._(
          readyToRender: animation.isCompleted,
          builder: builder,
        );
      },
      transitionBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget? child,
      ) {
        const firstHalf = Interval(0.0, 0.5, curve: Curves.easeOut);
        return FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: firstHalf,
            ),
          ),
          child: SizeTransition(
            sizeFactor: Tween(begin: 0.1, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: firstHalf,
              ),
            ),
            child: SizeTransition(
              axis: Axis.horizontal,
              sizeFactor: Tween(begin: 0.1, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
                ),
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: allPadding32,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500.0,
              maxHeight: 700.0,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
                color: Colors.black,
              ),
              child: readyToRender //
                  ? const SizedBox.expand()
                  : builder(context),
            ),
          ),
        ),
      ),
    );
  }
}
