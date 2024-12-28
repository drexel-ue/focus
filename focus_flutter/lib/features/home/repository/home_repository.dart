import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_flutter/features/home/repository/home_state.dart';

export 'package:focus_flutter/features/home/repository/home_state.dart';

/// A mixin that provides access to the [HomeRepository] instance.
mixin HomeRepoRef<T> on AsyncNotifier<T> {
  /// [HomeRepository].
  HomeRepository get homeRepo => ref.read(homeRepositoryProvider.notifier);
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

  /// Show a neutral [Snack].
  Future<void> showSnack(String message) async {
    _snackTimer?.cancel();
    state = state.copyWith(snack: Snack(message: message));
    _snackTimer = Timer(const Duration(seconds: 10), () => clearSnack());
  }

  /// Show a positive [Snack].
  Future<void> showPositiveSnack(String message) async {
    _snackTimer?.cancel();
    state = state.copyWith(snack: Snack(message: message, type: SnackType.positive));
    _snackTimer = Timer(const Duration(seconds: 10), () => clearSnack());
  }

  /// Show a negative [Snack].
  Future<void> showNegativeSnack(String message) async {
    _snackTimer?.cancel();
    state = state.copyWith(snack: Snack(message: message, type: SnackType.negative));
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
