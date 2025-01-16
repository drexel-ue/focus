import 'package:flutter/material.dart';

/// Bullet point text.
@immutable
class BulletPointText extends StatelessWidget {
  /// Constructs a const [BulletPointText].
  const BulletPointText(this.text, {super.key});

  /// Text.
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• '),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }
}
