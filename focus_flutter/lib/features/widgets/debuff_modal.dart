import 'package:flutter/material.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/focus_choice_chip.dart';
import 'package:focus_flutter/features/widgets/focus_window.dart';

/// Modal that displays debuff information.
@immutable
class DebuffModal extends StatelessWidget {
  /// Constructs a const [DebuffModal].
  const DebuffModal._({required this.debuff});

  /// Shows a [DebuffModal].
  static void show(BuildContext context, UserDebuff debuff) {
    FocusWindow.show(
      context,
      (BuildContext context, CloseWindow closeModal) {
        return DebuffModal._(debuff: debuff);
      },
    );
  }

  /// [UserBuff].
  final UserDebuff debuff;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: allPadding16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: FocusChoiceChip(
              label: debuff.name,
              selected: true,
              selectedColor: debuff.color,
              onSelected: (bool selected) {},
            ),
          ),
          verticalMargin16,
          Center(
            child: Text(debuff.description),
          ),
          verticalMargin16,
          FocusButton(
            onTap: () => Navigator.of(context).pop(),
            filled: true,
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
