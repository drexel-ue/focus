import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Denotes a tab of the home page view.
enum HomeTab {
  /// Stats.
  stats('STATS'),

  /// Goals.
  goals('GOALS'),

  /// Routines.
  routines('ROUTINES'),

  /// Tasks.
  tasks('TASKS'),

  /// Games.
  games('GAMES'),

  /// Settings.
  settings('SETTINGS'),

  //
  ;

  const HomeTab(this.label);

  /// Button label.
  final String label;
}

/// State of [HomeRepository].
@immutable
class HomeState {
  /// Constructs a const [HomeState].
  const HomeState({
    required this.tab,
    required this.menuOpen,
  });

  /// Current tab.
  final HomeTab tab;

  /// Is the overlay menu open?
  final bool menuOpen;

  /// Creates a new [HomeState] while preserving data.
  HomeState copyWith({HomeTab? tab, bool? menuOpen}) {
    return HomeState(
      tab: tab ?? this.tab,
      menuOpen: menuOpen ?? this.menuOpen,
    );
  }
}

/// Provides access to the [HomeRepository].
final homeRepositoryProvider = NotifierProvider<HomeRepository, HomeState>(() => HomeRepository());

/// Manages the home page view.
class HomeRepository extends Notifier<HomeState> {
  set tab(HomeTab value) => state = state.copyWith(tab: value);

  /// Open/close overlay menu.
  void toggleMenu() => state = state.copyWith(menuOpen: !state.menuOpen);

  /// Close overlay menu.
  void closeMenu() => state = state.copyWith(menuOpen: false);

  @override
  HomeState build() {
    // FIXME(drexel-ue): should we remember the last visited tab on start? maybe the most frequently visited?
    return const HomeState(
      tab: HomeTab.stats,
      menuOpen: false,
    );
  }
}
