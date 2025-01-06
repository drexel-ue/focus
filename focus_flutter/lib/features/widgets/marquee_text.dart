import 'package:flutter/material.dart';

/// Side scrolling text.
@immutable
class MarqueeText extends StatefulWidget {
  /// Constructs a const [MarqueeText].
  const MarqueeText(
    this.text, {
    super.key,
    this.animationDuration = const Duration(milliseconds: 6000),
    this.backDuration = const Duration(milliseconds: 800),
    this.pauseDuration = const Duration(milliseconds: 800),
    this.style,
  });

  /// Time it takes to scroll forward.
  final Duration animationDuration;

  /// Time it takes to reset;
  final Duration backDuration;

  /// Time between starting forward and reset scrolls.
  final Duration pauseDuration;

  /// Text to be scrolled.
  final String text;

  /// [TextStyle].
  final TextStyle? style;

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(initialScrollOffset: 50.0);
    WidgetsBinding.instance.addPostFrameCallback(_scroll);
  }

  void _scroll(_) async {
    while (scrollController.hasClients) {
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: widget.animationDuration,
          curve: Curves.ease,
        );
      }
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          0.0,
          duration: widget.backDuration,
          curve: Curves.easeOut,
        );
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Text(
        widget.text,
        style: widget.style ?? const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
