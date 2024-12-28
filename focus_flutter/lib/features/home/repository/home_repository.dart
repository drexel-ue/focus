import 'dart:async';

import 'package:flutter/foundation.dart';
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

/// Type of [Snack].
enum SnackType {
  /// Neutral.
  neutral,

  /// Positive.
  positive,

  /// Negative.
  negative;
}

/// Message to display.
@immutable
class Snack {
  /// Constructs a const [Snack].
  const Snack({
    required this.message,
    required this.type,
    this.onTap,
  });

  /// Display text.
  final String message;

  /// Type.
  final SnackType type;

  /// Optional callback to be ran when [Snack] is tapped.
  final VoidCallback? onTap;
}

/// State of [HomeRepository].
@immutable
class HomeState {
  /// Constructs a const [HomeState].
  const HomeState({
    required this.tab,
    required this.menuOpen,
    this.snack,
  });

  /// Current tab.
  final HomeTab tab;

  /// Is the overlay menu open?
  final bool menuOpen;

  /// A [Snack] to display.
  final Snack? snack;

  /// Creates a new [HomeState] while preserving data.
  HomeState copyWith({
    HomeTab? tab,
    bool? menuOpen,
    Snack? snack,
  }) {
    return HomeState(
      tab: tab ?? this.tab,
      menuOpen: menuOpen ?? this.menuOpen,
      snack: snack,
    );
  }
}

/// Provides access to the [HomeRepository].
final homeRepositoryProvider = NotifierProvider<HomeRepository, HomeState>(() => HomeRepository());

/// Manages the home page view.
class HomeRepository extends Notifier<HomeState> {
  Timer? _snackTimer;

  set tab(HomeTab value) => state = state.copyWith(tab: value);

  /// Open/close overlay menu.
  void toggleMenu() => state = state.copyWith(menuOpen: !state.menuOpen);

  /// Close overlay menu.
  void closeMenu() => state = state.copyWith(menuOpen: false);

  /// Show a [Snack].
  Future<void> showSnack(Snack snack) async {
    _snackTimer?.cancel();
    state = state.copyWith(snack: snack);
    _snackTimer = Timer(const Duration(seconds: 10), () => clearSnack());
  }

  /// Clear current [Snack].
  void clearSnack() {
    _snackTimer?.cancel();
    state = state.copyWith();
  }

  @override
  HomeState build() {
    // FIXME(drexel-ue): should we remember the last visited tab on start? maybe the most frequently visited?
    return const HomeState(
      tab: HomeTab.stats,
      menuOpen: false,
    );
  }
}
