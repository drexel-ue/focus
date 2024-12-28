import 'package:flutter/material.dart';
import 'package:focus_flutter/app/layout.dart';

/// Focus themed modal.
@immutable
class FocusModal extends StatefulWidget {
  const FocusModal._({
    required this.builder,
  });

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
          builder: builder,
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
  State<FocusModal> createState() => _FocusModalState();
}

class _FocusModalState extends State<FocusModal> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    )
      ..addListener(_listener)
      ..forward();
  }

  void _listener() => setState(() {});

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: allPadding32,
          child: FractionallySizedBox(
            widthFactor: Tween<double>(begin: 0.0, end: 1.0)
                .animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
                  ),
                )
                .value,
            heightFactor: Tween<double>(begin: 0.0, end: 1.0)
                .animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
                  ),
                )
                .value,
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
                child: _animationController.isCompleted //
                    ? widget.builder(context)
                    : const SizedBox.expand(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
