import 'package:flutter/material.dart';
import 'package:focus_client/focus_client.dart';

/// Focus themed choice chip.
@immutable
class FocusChoiceChip extends StatelessWidget {
  /// Constructs a const [FocusChoiceChip].
  const FocusChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    required this.selectedColor,
    required this.onSelected,
  });

  /// Label.
  final String label;

  /// Selected.
  final bool selected;

  /// Selected color.
  final Color selectedColor;

  /// On selected callback.
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    final offsetColor = selectedColor.computeLuminance() > 0.5 //
        ? AppColors.black
        : AppColors.white;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          color: selected ? offsetColor : Colors.white38,
        ),
      ),
      selected: selected,
      selectedColor: selectedColor,
      showCheckmark: false,
      elevation: 0.0,
      pressElevation: 0.0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
      onSelected: (bool selected) => onSelected(selected),
    );
  }
}
