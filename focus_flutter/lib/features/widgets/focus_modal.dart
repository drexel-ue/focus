import 'package:flutter/material.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/widgets/focus_border.dart';

/// Callback for closing a modal with an optional value.
typedef CloseModal<T> = void Function([T? value]);

/// Callback for rendering the content of the model. Provides a callback for closing the modal.
typedef ModalBuilder<T> = Widget Function(BuildContext context, CloseModal<T?> closeModel);

/// Focus themed modal.
@immutable
class FocusModal<T> extends StatefulWidget {
  const FocusModal._({
    required this.builder,
    this.constraints = const BoxConstraints(
      maxWidth: 500.0,
      maxHeight: 700.0,
    ),
  });

  /// Content builder.
  final ModalBuilder<T> builder;

  /// Constraints for the modal.
  final BoxConstraints constraints;

  /// Show the modal.
  static Future<T?> show<T>(
    BuildContext context,
    ModalBuilder builder, {
    BoxConstraints constraints = const BoxConstraints(),
  }) async {
    return await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 550),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return FocusModal._(
          builder: builder,
          constraints: constraints,
        );
      },
      transitionBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget? child,
      ) {
        return child!;
      },
    );
  }

  @override
  State<FocusModal<T>> createState() => _FocusModalState<T>();
}

class _FocusModalState<T> extends State<FocusModal<T>> {
  @override
  Widget build(BuildContext context) {
    final transitionController = ModalRoute.of(context)!.animation!;
    return SafeArea(
      child: Center(
        child: Padding(
          padding: allPadding32,
          child: ConstrainedBox(
            constraints: widget.constraints,
            child: FocusBorder(
              child: SizeTransition(
                axis: Axis.horizontal,
                fixedCrossAxisSizeFactor: 1.0,
                sizeFactor: CurvedAnimation(
                  parent: transitionController,
                  curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
                ),
                child: SizeTransition(
                  axis: Axis.vertical,
                  fixedCrossAxisSizeFactor: 1.0,
                  sizeFactor: CurvedAnimation(
                    parent: transitionController,
                    curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
                  ),
                  child: widget.builder(
                    context,
                    ([T? value]) async {
                      if (context.mounted) {
                        Navigator.of(context).pop(value);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
