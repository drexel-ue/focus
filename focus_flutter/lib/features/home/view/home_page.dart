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
import 'package:focus_flutter/features/widget/marquee_text.dart';
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeRepositoryProvider);
    final notifier = ref.read(homeRepositoryProvider.notifier);
    final snack = homeState.snack;
    final text = snack?.message ?? homeState.tab.label;
    final color = switch (homeState.snack?.type) {
      SnackType.neutral => Colors.white,
      SnackType.positive => Colors.green,
      SnackType.negative => Colors.red,
      _ => null,
    };
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // FIXME(drexel-ue): can this me made to stick to the right?
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 46.0,
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 550),
                    child: IntrinsicWidth(
                      child: CustomPaint(
                        painter: FocusPainter(
                          color: color,
                        ),
                        child: InkWell(
                          onTap: homeState.snack?.onTap,
                          onLongPress: homeState.snack != null ? () => notifier.clearSnack() : null,
                          child: Center(
                            child: Padding(
                              padding: horizontalPadding16,
                              child: MarqueeText(
                                text,
                                style: homeState.snack != null //
                                    ? TextStyle(
                                        fontWeight: switch (homeState.snack!.type) {
                                          SnackType.neutral => FontWeight.w600,
                                          _ => FontWeight.w700,
                                        },
                                        color: color,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            horizontalMargin16,
            CompositedTransformTarget(
              link: _layerLink,
              child: FocusButton(
                onTap: () => notifier.toggleMenu(),
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
