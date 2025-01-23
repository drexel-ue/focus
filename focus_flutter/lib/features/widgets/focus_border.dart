import 'package:flutter/material.dart';
import 'package:focus_client/focus_client.dart';

/// Focus themed border.
@immutable
class FocusBorder extends StatelessWidget {
  /// Constructs a const [FocusBorder].
  const FocusBorder({
    super.key,
    this.thicc = false,
    this.color = AppColors.black,
    required this.child,
  });

  /// 2.5 width border.
  final bool thicc;

  /// Background color.
  final Color color;

  /// Child.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.white,
          width: thicc ? 2.5 : 2.0,
          strokeAlign: BorderSide.strokeAlignCenter,
        ),
        color: color,
      ),
      child: child,
    );
  }
}
