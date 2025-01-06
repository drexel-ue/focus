import 'package:flutter/material.dart';

/// [CustomPainter] with focus reticles around child.
@immutable
class FocusPainter extends CustomPainter {
  /// Constructs a const [FocusPainter].
  FocusPainter({
    Color? color,
  }) : _paint = Paint()
          ..color = color ?? Colors.white
          ..strokeWidth = 2.0;

  static const _lineLength = 8.0;

  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    // top left.
    canvas.drawLine(const Offset(0.0, _lineLength), const Offset(0.0, 0.0), _paint);
    canvas.drawLine(const Offset(0.0, 0.0), const Offset(_lineLength, 0.0), _paint);
    // top right.
    canvas.drawLine(Offset(size.width - _lineLength, 0.0), Offset(size.width, 0.0), _paint);
    canvas.drawLine(Offset(size.width, 0.0), Offset(size.width, _lineLength), _paint);
    // bottom right.
    canvas.drawLine(
        Offset(size.width, size.height - _lineLength), Offset(size.width, size.height), _paint);
    canvas.drawLine(
        Offset(size.width, size.height), Offset(size.width - _lineLength, size.height), _paint);
    // bottom left.
    canvas.drawLine(Offset(_lineLength, size.height), Offset(0.0, size.height), _paint);
    canvas.drawLine(Offset(0.0, size.height), Offset(0.0, size.height - _lineLength), _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
