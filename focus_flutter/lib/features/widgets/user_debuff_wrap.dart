import 'package:flutter/material.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/features/widgets/debuff_modal.dart';
import 'package:focus_flutter/features/widgets/focus_choice_chip.dart';

/// Displays a list of [UserDebuff]s in a wrap.
@immutable
class UserDebuffWrap extends StatelessWidget {
  /// Constructs a const [UserDebuffWrap].
  const UserDebuffWrap({
    super.key,
    required this.debuffs,
    required this.isSelected,
    this.onSelected,
  });

  /// [UserDebuff]s to display.
  final List<UserDebuff> debuffs;

  /// Gettter for whether a [UserDebuff] is selected.
  final bool Function(UserDebuff buff) isSelected;

  /// Callback to run when a [UserDebuff] is selected.
  final void Function(bool selected, UserDebuff buff)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: [
        for (final debuff in debuffs) //
          FocusChoiceChip(
            label: debuff.name,
            selected: isSelected(debuff),
            selectedColor: debuff.color,
            onSelected: onSelected != null //
                ? (bool selected) => onSelected!(selected, debuff)
                : null,
            onLongPress: () => DebuffModal.show(context, debuff),
          ),
      ],
    );
  }
}
