import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/features/home/repository/home_repository.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';

/// Ovarlay menu for the [HomePage].
@immutable
class HomeOverlayMenu extends ConsumerStatefulWidget {
  /// Constructs a const [HomeOverlayMenu].
  const HomeOverlayMenu({
    super.key,
    required this.layerLink,
    required this.tabs,
    required this.closeMenu,
  });

  /// [LayerLink] for [CompositedTransformFollower].
  final LayerLink layerLink;

  /// Tabs to show.
  final List<HomeTab> tabs;

  /// Callback for closing the menu.
  final VoidCallback closeMenu;

  @override
  ConsumerState<HomeOverlayMenu> createState() => _OverlayMenuState();
}

class _OverlayMenuState extends ConsumerState<HomeOverlayMenu> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final _offsetAnimations = <Animation<double>>[];
  final _opacityAnimations = <Animation<double>>[];
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
      reverseDuration: const Duration(milliseconds: 250),
    );
    _initializeTweens();
    _colorAnimation = ColorTween(begin: AppColors.transparent, end: AppColors.black)
        .animate(_animationController);
    _animationController.forward();
  }

  void _initializeTweens() {
    final segment = 1.0 / widget.tabs.length;
    for (int index = 0; index < widget.tabs.length; index++) {
      final curvedAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          index * segment,
          (index * segment) + segment,
          curve: Curves.easeOut,
        ),
      );
      _offsetAnimations.add(
        Tween<double>(
          begin: (48.0 + 16.0) * (widget.tabs.length - index),
          end: 0.0,
        ).animate(curvedAnimation),
      );
      _opacityAnimations.add(
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(curvedAnimation),
      );
    }
  }

  Future<void> _homeRepositoryListener(HomeState? prev, HomeState next) async {
    if (!next.menuOpen) {
      await _animationController.reverse();
      if (mounted) {
        widget.closeMenu();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(homeRepositoryProvider, _homeRepositoryListener);
    return CompositedTransformFollower(
      link: widget.layerLink,
      followerAnchor: Alignment.bottomRight,
      targetAnchor: Alignment.topRight,
      offset: const Offset(1.0, 0.0),
      child: Padding(
        padding: bottomPadding16,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return ColoredBox(
              color: _colorAnimation.value!,
              child: child,
            );
          },
          child: Transform.translate(
            offset: const Offset(-1.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int index = 0; index < widget.tabs.length; index++) ...[
                  AnimatedBuilder(
                    animation: _offsetAnimations[index],
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0.0, _offsetAnimations[index].value),
                        child: child,
                      );
                    },
                    child: FadeTransition(
                      opacity: _opacityAnimations[index],
                      child: FocusButton(
                        onTap: () {
                          final homeRepository = ref.read(homeRepositoryProvider.notifier);
                          homeRepository
                            ..tab = widget.tabs[index]
                            ..closeMenu();
                        },
                        child: Text(widget.tabs[index].label),
                      ),
                    ),
                  ),
                  if (index < widget.tabs.length - 1) //
                    verticalMargin16,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
