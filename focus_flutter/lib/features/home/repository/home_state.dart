import 'package:flutter/foundation.dart';
import 'package:focus_flutter/features/home/repository/home_tab.dart';
import 'package:focus_flutter/features/home/repository/snack.dart';

export 'package:focus_flutter/features/home/repository/home_tab.dart';
export 'package:focus_flutter/features/home/repository/snack.dart';

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
