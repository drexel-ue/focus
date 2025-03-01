import 'package:flutter/material.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/features/widgets/buff_modal.dart';
import 'package:focus_flutter/features/widgets/focus_choice_chip.dart';

/// Displays a list of [UserBuff]s in a wrap.
@immutable
class UserBuffWrap extends StatelessWidget {
  /// Constructs a const [UserBuffWrap].
  const UserBuffWrap({
    super.key,
    required this.buffs,
    required this.isSelected,
    this.onSelected,
  });

  /// [UserBuff]s to display.
  final List<UserBuff> buffs;

  /// Gettter for whether a [UserBuff] is selected.
  final bool Function(UserBuff buff) isSelected;

  /// Callback to run when a [UserBuff] is selected.
  final void Function(bool selected, UserBuff buff)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: [
        for (final buff in buffs) //
          FocusChoiceChip(
            label: buff.name,
            selected: isSelected(buff),
            selectedColor: buff.color,
            onSelected: onSelected != null //
                ? (bool selected) => onSelected!(selected, buff)
                : null,
            onLongPress: () => BuffModal.show(context, buff),
          ),
      ],
    );
  }
}
