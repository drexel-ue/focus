import 'package:flutter/material.dart';
import 'package:focus_client/focus_client.dart';

/// Focus themed slider thumb.
@immutable
class FocusSliderThumbShape extends SliderComponentShape {
  static const _thumbWidth = 8.0;
  static const _thumbHeight = 16.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(_thumbWidth, _thumbHeight);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    canvas.drawRect(
      Rect.fromPoints(
        Offset(center.dx - _thumbWidth / 2.0, center.dy - _thumbHeight / 2.0),
        Offset(center.dx + _thumbWidth / 2.0, center.dy + _thumbHeight / 2.0),
      ),
      Paint()
        ..color = AppColors.white
        ..style = PaintingStyle.fill,
    );
  }
}
