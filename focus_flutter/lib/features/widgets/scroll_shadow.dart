import 'package:flutter/widgets.dart';
import 'package:focus_client/focus_client.dart';

/// Focus themed scroll indicator.
@immutable
class ScrollShadow extends StatefulWidget {
  /// Constructs a const [ScrollShodow].
  const ScrollShadow({
    super.key,
    this.controller,
    this.padding,
    this.axis = Axis.vertical,
    required this.child,
  });

  /// Optional scroll controller.
  final ScrollController? controller;

  /// Optional padding passed to the underlying scroll view.
  final EdgeInsets? padding;

  /// Axis.
  final Axis axis;

  /// Child.
  final Widget child;

  @override
  State<ScrollShadow> createState() => _ScrollShadowState();
}

class _ScrollShadowState extends State<ScrollShadow> {
  static final _transparentWhite = AppColors.white.withValues(alpha: 0);
  static final _startColor = AppColors.white.withValues(alpha: 0.5);
  static const _shadowHeight = 48.0;

  bool _atStart = true;
  bool _atEnd = false;

  bool _onNotification(ScrollMetrics metrics) {
    final atStart = metrics.pixels <= metrics.minScrollExtent;
    final atEnd = metrics.pixels >= metrics.maxScrollExtent;
    if (atStart != _atStart || atEnd != _atEnd) {
      setState(() {
        _atStart = atStart;
        _atEnd = atEnd;
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final startGradient = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: widget.axis == Axis.vertical ? Alignment.topCenter : Alignment.centerLeft,
          end: widget.axis == Axis.vertical ? Alignment.bottomCenter : Alignment.centerRight,
          colors: [_startColor, _transparentWhite],
        ),
      ),
    );
    final endGradient = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: widget.axis == Axis.vertical ? Alignment.bottomCenter : Alignment.centerRight,
          end: widget.axis == Axis.vertical ? Alignment.topCenter : Alignment.centerLeft,
          colors: [_startColor, _transparentWhite],
        ),
      ),
    );
    return Stack(
      children: [
        NotificationListener<ScrollMetricsNotification>(
          onNotification: (ScrollMetricsNotification notification) {
            return _onNotification(notification.metrics);
          },
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              return _onNotification(notification.metrics);
            },
            child: SingleChildScrollView(
              controller: widget.controller,
              padding: widget.padding,
              scrollDirection: widget.axis,
              child: widget.child,
            ),
          ),
        ),
        if (!_atStart)
          if (widget.axis == Axis.vertical)
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              height: _shadowHeight,
              child: startGradient,
            )
          else
            Positioned(
              top: 0.0,
              left: 0.0,
              bottom: 0.0,
              width: _shadowHeight,
              child: startGradient,
            ),
        if (!_atEnd)
          if (widget.axis == Axis.vertical)
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              height: _shadowHeight,
              child: endGradient,
            )
          else
            Positioned(
              bottom: 0.0,
              right: 0.0,
              top: 0.0,
              width: _shadowHeight,
              child: endGradient,
            ),
      ],
    );
  }
}
