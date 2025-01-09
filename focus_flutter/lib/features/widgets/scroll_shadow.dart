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
    required this.child,
  });

  /// Optional scroll controller.
  final ScrollController? controller;

  /// Optional padding passed to the underlying scroll view.
  final EdgeInsets? padding;

  /// Child.
  final Widget child;

  @override
  State<ScrollShadow> createState() => _ScrollShadowState();
}

class _ScrollShadowState extends State<ScrollShadow> {
  static final _transparentWhite = AppColors.white.withAlpha(0);
  static const _white = AppColors.white;
  static final _startGradient = DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [_transparentWhite, _white],
      ),
    ),
  );
  static final _endGradient = DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [_white, _transparentWhite],
      ),
    ),
  );
  static const _shadowHeight = 12.0;

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
              child: widget.child,
            ),
          ),
        ),
        if (!_atStart) //
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            height: _shadowHeight,
            child: _startGradient,
          ),
        if (!_atEnd) //
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            height: _shadowHeight,
            child: _endGradient,
          ),
      ],
    );
  }
}
