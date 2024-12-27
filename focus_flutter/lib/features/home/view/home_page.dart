import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:focus_flutter/app/routing.dart';
import 'package:focus_flutter/features/goals/view/goals_page.dart';
import 'package:focus_flutter/features/home/repository/home_repository.dart';
import 'package:focus_flutter/features/settings/view/settings_page.dart';
import 'package:focus_flutter/features/stats/view/stats_page.dart';
import 'package:focus_flutter/features/tasks/view/tasks_page.dart';
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
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: ref.read(homeRepositoryProvider).index);
  }

  void _homeRepositoryListener(HomeTab? prev, HomeTab next) {
    _controller.animateToPage(
      next.index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
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
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                StatsPage(),
                GoalsPage(),
                TasksPage(),
                SettingsPage(),
              ],
            ),
          ),
        ),
        verticalMargin16,
        Row(
          children: [
            for (final tab in HomeTab.values) //
              Expanded(
                child: Padding(
                  padding: tab == HomeTab.settings ? EdgeInsets.zero : rightPadding16,
                  child: _HomeTabButton(
                    tab: tab,
                    onTap: () => ref.read(homeRepositoryProvider.notifier).tab = tab,
                    label: tab.label,
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
class _HomeTabButton extends ConsumerWidget {
  const _HomeTabButton({
    required this.tab,
    required this.onTap,
    required this.label,
  });

  final HomeTab tab;
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(homeRepositoryProvider);
    final selected = tab == currentTab;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: selected ? 2.5 : 2.0,
        ),
      ),
      child: InkWell(
        onTap: () => onTap(),
        child: SizedBox(
          height: 48.0,
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: selected ? FontWeight.w600 : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
