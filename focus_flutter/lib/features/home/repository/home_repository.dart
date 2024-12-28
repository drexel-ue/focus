import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_flutter/features/home/repository/home_state.dart';

export 'package:focus_flutter/features/home/repository/home_state.dart';

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
