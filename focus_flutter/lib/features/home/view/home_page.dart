import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_flutter/app/assets.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/app/routing.dart';
import 'package:focus_flutter/features/games/view/games_page.dart';
import 'package:focus_flutter/features/goals/view/goals_page.dart';
import 'package:focus_flutter/features/home/repository/home_repository.dart';
import 'package:focus_flutter/features/routines/view/routines_page.dart';
import 'package:focus_flutter/features/settings/view/settings_page.dart';
import 'package:focus_flutter/features/stats/view/stats_page.dart';
import 'package:focus_flutter/features/tasks/view/tasks_page.dart';
import 'package:focus_flutter/features/widget/focus_button.dart';
import 'package:go_router/go_router.dart';

/// Home Page.
@immutable
class HomePage extends ConsumerStatefulWidget {
  /// Constructs a const [HomePage].
  const HomePage({super.key});

  /// Path.
  static const path = '/';

  /// [GoRoute].
  static GoRoute route = GoRoute(
    path: path,
    pageBuilder: defaultPageBuilder(const HomePage()),
  );

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final PageController _pageController;
  late final OverlayPortalController _overlayController;
  late final LayerLink _layerLink;

  bool _overlayOpen = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: ref.read(homeRepositoryProvider).index);
    _overlayController = OverlayPortalController();
    _layerLink = LayerLink();
  }

  void _homeRepositoryListener(HomeTab? prev, HomeTab next) {
    _pageController.animateToPage(
      next.index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _toggleOverlay() {
    setState(() {
      _overlayController.toggle();
      _overlayOpen = !_overlayOpen;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(homeRepositoryProvider, _homeRepositoryListener);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0),
            ),
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: const [
                StatsPage(),
                GoalsPage(),
                TasksPage(),
                RoutinesPage(),
                GamesPage(),
                SettingsPage(),
              ],
            ),
          ),
        ),
        verticalMargin16,
        Row(
          children: [
            Expanded(
              child: Text(
                ref.watch(homeRepositoryProvider).label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            horizontalMargin16,
            CompositedTransformTarget(
              link: _layerLink,
              child: FocusButton(
                onTap: () => _toggleOverlay(),
                square: true,
                selected: _overlayOpen,
                child: OverlayPortal(
                  controller: _overlayController,
                  overlayChildBuilder: (BuildContext context) {
                    return Positioned(
                      width: 200.0,
                      child: _OverlayMenu(
                        layerLink: _layerLink,
                        onSelection: () => _toggleOverlay(),
                      ),
                    );
                  },
                  child: SvgPicture.asset(AppAssets.focusIcon),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

@immutable
class _OverlayMenu extends ConsumerWidget {
  const _OverlayMenu({
    required this.layerLink,
    required this.onSelection,
  });

  final LayerLink layerLink;
  final VoidCallback onSelection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(homeRepositoryProvider);
    final tabs = HomeTab.values.where((HomeTab tab) => tab != currentTab);
    return CompositedTransformFollower(
      link: layerLink,
      followerAnchor: Alignment.bottomRight,
      targetAnchor: Alignment.topRight,
      child: ColoredBox(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final tab in tabs) ...[
              FocusButton(
                onTap: () {
                  ref.read(homeRepositoryProvider.notifier).tab = tab;
                  onSelection();
                },
                child: Text(tab.label),
              ),
              verticalMargin16,
            ],
          ],
        ),
      ),
    );
  }
}
