import 'package:flutter/material.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/focus_choice_chip.dart';
import 'package:focus_flutter/features/widgets/focus_modal.dart';

/// Modal that displays buff information.
@immutable
class BuffModal extends StatelessWidget {
  /// Constructs a const [BuffModal].
  const BuffModal._({required this.buff});

  /// Shows a [BuffModal].
  static void show(BuildContext context, UserBuff buff) {
    FocusModal.show(
      context,
      (BuildContext context, CloseModal closeModal) {
        return BuffModal._(buff: buff);
      },
    );
  }

  /// [UserBuff].
  final UserBuff buff;

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
              label: buff.name,
              selected: true,
              selectedColor: buff.color,
              onSelected: (bool selected) {},
            ),
          ),
          verticalMargin16,
          Center(
            child: Text(buff.description),
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
