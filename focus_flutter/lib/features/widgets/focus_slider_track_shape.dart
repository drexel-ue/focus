import 'package:flutter/material.dart';
import 'package:focus_client/focus_client.dart';

/// Focus themed slider track.
@immutable
class FocusSliderTrackShape extends SliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = true,
    bool isDiscrete = false,
  }) {
    final double thumbWidth = sliderTheme.thumbShape!.getPreferredSize(true, isDiscrete).width;
    final double trackHeight = sliderTheme.trackHeight!;
    assert(thumbWidth >= 0);
    assert(trackHeight >= 0);
    assert(parentBox.size.width >= thumbWidth);
    assert(parentBox.size.height >= trackHeight);
    final double trackLeft = offset.dx + thumbWidth / 2;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - thumbWidth;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = true,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    context.canvas.drawRect(
      Rect.fromLTWH(
        offset.dx,
        parentBox.size.height / 2 - 4.0,
        thumbCenter.dx - offset.dx,
        sliderTheme.trackHeight!,
      ),
      Paint()
        ..color = AppColors.white
        ..style = PaintingStyle.fill,
    );
    context.canvas.drawRect(
      Rect.fromLTWH(
        thumbCenter.dx,
        parentBox.size.height / 2 - 4.0,
        parentBox.size.width - thumbCenter.dx,
        sliderTheme.trackHeight!,
      ),
      Paint()
        ..color = AppColors.white
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke,
    );
  }
}
