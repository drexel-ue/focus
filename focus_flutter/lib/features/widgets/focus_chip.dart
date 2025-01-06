import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:focus_client/focus_client.dart';

/// Focus themed chip.
@immutable
class FocusChip extends StatelessWidget {
  /// Constructs a const [FocusChip].
  const FocusChip({
    super.key,
    required this.label,
    this.trailing,
    required this.onTap,
  });

  /// Label text.
  final String label;

  /// Optional trailing [Widget].
  final Widget? trailing;

  /// On tap callback.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.white, width: 1.0),
        color: AppColors.black,
      ),
      child: SizedBox(
        height: 32.0,
        child: Padding(
          padding: horizontalPadding8,
          child: Row(
            children: [
              Text(label),
              if (trailing case Widget trailing) ...[
                horizontalMargin8,
                SizedBox.square(
                  dimension: 18.0,
                  child: trailing,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
