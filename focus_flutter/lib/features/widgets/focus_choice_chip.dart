import 'package:flutter/material.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';

/// Focus themed choice chip.
@immutable
class FocusChoiceChip extends StatefulWidget {
  /// Constructs a const [FocusChoiceChip].
  const FocusChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    required this.selectedColor,
    this.onSelected,
    this.onLongPress,
  });

  /// Label.
  final String label;

  /// Selected.
  final bool selected;

  /// Selected color.
  final Color selectedColor;

  /// On selected callback.
  final ValueChanged<bool>? onSelected;

  /// On long press callback.
  final VoidCallback? onLongPress;

  @override
  State<FocusChoiceChip> createState() => _FocusChoiceChipState();
}

class _FocusChoiceChipState extends State<FocusChoiceChip> {
  late bool _selected = widget.selected;
  @override
  Widget build(BuildContext context) {
    final offsetColor = widget.selectedColor.computeLuminance() > 0.5 //
        ? AppColors.black
        : AppColors.white;
    return IntrinsicWidth(
      child: Material(
        clipBehavior: Clip.antiAlias,
        color: widget.selected ? widget.selectedColor : Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: _selected //
                ? widget.selectedColor.withValues(alpha: 0.3)
                : AppColors.dullGray,
            width: 2.0,
          ),
        ),
        child: InkWell(
          onTap: widget.onSelected != null
              ? () {
                  setState(() => _selected = !_selected);
                  widget.onSelected!(_selected);
                }
              : null,
          onLongPress: widget.onLongPress,
          child: Padding(
            padding: allPadding8,
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: _selected ? offsetColor : AppColors.dullGray,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
