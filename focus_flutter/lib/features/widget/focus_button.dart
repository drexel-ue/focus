import 'package:flutter/material.dart';
import 'package:focus_flutter/app/layout.dart';

/// Focus themed button.
@immutable
class FocusButton extends StatelessWidget {
  /// Constructs a const [FocusButton].
  const FocusButton({
    super.key,
    this.selected = false,
    this.square = false,
    required this.onTap,
    required this.child,
  });

  /// Is this button selected?
  final bool selected;

  /// Square?
  final bool square;

  /// Callback to be ran on tap.
  final VoidCallback onTap;

  /// Child.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: selected ? 2.5 : 2.0,
        ),
      ),
      child: InkWell(
        onTap: () => onTap(),
        child: SizedBox(
          height: 48.0,
          width: square ? 48.0 : null,
          child: Center(
            child: Padding(
              padding: square ? allPadding4 : horizontalPadding10,
              child: DefaultTextStyle(
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: selected ? FontWeight.w600 : null,
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
