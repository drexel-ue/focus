import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/assets.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/app/routing.dart';
import 'package:focus_flutter/features/run_routine/repository/run_routine_repository.dart';
import 'package:focus_flutter/features/run_routine/view/run_routine_window.dart';
import 'package:focus_flutter/features/tools/view/tools_page.dart';
import 'package:focus_flutter/features/goals/view/goals_page.dart';
import 'package:focus_flutter/features/home/repository/home_repository.dart';
import 'package:focus_flutter/features/home/view/home_overlay_menu.dart';
import 'package:focus_flutter/features/routines/view/routines_page.dart';
import 'package:focus_flutter/features/settings/view/settings_page.dart';
import 'package:focus_flutter/features/stats/view/stats_page.dart';
import 'package:focus_flutter/features/tasks/view/tasks_page.dart';
import 'package:focus_flutter/features/widgets/focus_border.dart';
import 'package:focus_flutter/features/widgets/focus_button.dart';
import 'package:focus_flutter/features/widgets/focus_painter.dart';
import 'package:focus_flutter/features/widgets/marquee_text.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForRunningRoutine();
    });
  }

  void _homeRepositoryListener(HomeState? prev, HomeState next) {
    _pageController.jumpToPage(next.tab.index);
    final menuOpen = next.menuOpen;
    if (menuOpen && !_overlayController.isShowing) {
      _overlayController.show();
    }
  }

  Future<void> _checkForRunningRoutine() async {
    if (await ref.read(runRoutineRepositoryProvider.notifier).checkForRunningRoutine()) {
      if (mounted) {
        RunRoutineWindow.show(context);
      }
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
      SnackType.neutral => AppColors.white,
      SnackType.positive => AppColors.limeGreen,
      SnackType.negative => AppColors.redOrange,
      _ => null,
    };
    ref.listen(homeRepositoryProvider, _homeRepositoryListener);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: FocusBorder(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: const [
                StatsPage(),
                GoalsPage(),
                RoutinesPage(),
                TasksPage(),
                ToolsPage(),
                SettingsPage(),
              ],
            ),
          ),
        ),
        verticalMargin16,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 48.0,
                  child: CustomPaint(
                    painter: FocusPainter(
                      color: color,
                    ),
                    child: InkWell(
                      onTap: homeState.snack?.onTap,
                      onLongPress: homeState.snack != null ? () => notifier.clearSnack() : null,
                      child: AnimatedSize(
                        duration: const Duration(milliseconds: 550),
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: horizontalPadding16,
                          child: UnconstrainedBox(
                            constrainedAxis: Axis.vertical,
                            child: Center(
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
