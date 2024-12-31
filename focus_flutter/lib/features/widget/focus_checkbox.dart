import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_flutter/app/assets.dart';
import 'package:focus_flutter/features/widget/focus_painter.dart';

/// Focus themed checkbox.
@immutable
class FocusCheckbox extends StatelessWidget {
  /// Constructs a const [FocusCheckbox].
  const FocusCheckbox({
    super.key,
    required this.selected,
    this.onTap,
  });

  /// Selected?
  final bool selected;

  /// Callback to run when tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 48.0,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        child: Center(
          child: SizedBox.square(
            dimension: 18.0,
            child: CustomPaint(
              painter: FocusPainter(),
              child: selected ? SvgPicture.asset(AppAssets.checkmark) : null,
            ),
          ),
        ),
      ),
    );
  }
}
