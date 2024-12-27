import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_flutter/app/assets.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/app/routing.dart';
import 'package:focus_flutter/features/games/view/games_page.dart';
import 'package:focus_flutter/features/goals/view/goals_page.dart';
import 'package:focus_flutter/features/home/repository/home_repository.dart';
import 'package:focus_flutter/features/home/view/home_overlay_menu.dart';
import 'package:focus_flutter/features/routines/view/routines_page.dart';
import 'package:focus_flutter/features/settings/view/settings_page.dart';
import 'package:focus_flutter/features/stats/view/stats_page.dart';
import 'package:focus_flutter/features/tasks/view/tasks_page.dart';
import 'package:focus_flutter/features/widget/focus_button.dart';
import 'package:focus_flutter/features/widget/focus_painter.dart';
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
  late final LayerLink _layerLink;
  late final OverlayPortalController _overlayController;

  List<HomeTab> get _tabs {
    final currentTab = ref.watch(homeRepositoryProvider).tab;
    return HomeTab.values.where((HomeTab tab) => tab != currentTab).toList();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: ref.read(homeRepositoryProvider).tab.index);
    _layerLink = LayerLink();
    _overlayController = OverlayPortalController();
  }

  void _homeRepositoryListener(HomeState? prev, HomeState next) {
    _pageController.animateToPage(
      next.tab.index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    final menuOpen = next.menuOpen;
    if (menuOpen && !_overlayController.isShowing) {
      _overlayController.show();
    }
  }

  void _toggleOverlay() => ref.read(homeRepositoryProvider.notifier).toggleMenu();

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
                RoutinesPage(),
                TasksPage(),
                GamesPage(),
                SettingsPage(),
              ],
            ),
          ),
        ),
        verticalMargin16,
        Row(
          children: [
            spacer,
            SizedBox(
              height: 46.0,
              child: CustomPaint(
                painter: const FocusPainter(),
                child: Center(
                  child: Padding(
                    padding: horizontalPadding16,
                    child: Text(
                      ref.watch(homeRepositoryProvider).tab.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            horizontalMargin16,
            CompositedTransformTarget(
              link: _layerLink,
              child: FocusButton(
                onTap: () => _toggleOverlay(),
                square: true,
                selected: _overlayController.isShowing,
                child: OverlayPortal(
                  controller: _overlayController,
                  overlayChildBuilder: (BuildContext context) {
                    return Positioned(
                      width: 200.0,
                      child: HomeOverlayMenu(
                        layerLink: _layerLink,
                        tabs: _tabs,
                        closeMenu: () => _overlayController.hide(),
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
