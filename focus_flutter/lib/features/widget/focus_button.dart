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
    this.filled = false,
    this.enabled = true,
    required this.onTap,
    required this.child,
  });

  /// Is this button selected?
  final bool selected;

  /// Square?
  final bool square;

  /// Fill?
  final bool filled;

  /// Enabled?
  final bool enabled;

  /// Callback to be ran on tap.
  final VoidCallback onTap;

  /// Child.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: selected ? 2.5 : 2.0,
        ),
        color: !enabled
            ? Colors.grey
            : filled //
                ? Colors.white
                : Colors.black,
      ),
      child: InkWell(
        onTap: enabled ? () => onTap() : null,
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
                  color: filled ? Colors.black : Colors.white,
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
