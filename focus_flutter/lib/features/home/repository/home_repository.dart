import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Denotes a tab of the home page view.
enum HomeTab {
  /// Stats.
  stats('STATS'),

  /// Goals.
  goals('GOALS'),

  /// Tasks.
  tasks('TASKS'),

  /// Routines.
  routines('ROUTINES'),

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

/// Provides access to the [HomeRepository].
final homeRepositoryProvider = NotifierProvider<HomeRepository, HomeTab>(() => HomeRepository());

/// Manages the home page view.
class HomeRepository extends Notifier<HomeTab> {
  set tab(HomeTab value) => state = value;

  @override
  HomeTab build() {
    // FIXME(drexel-ue): should we remember the last visited tab on start? maybe the most frequently visited?
    return HomeTab.stats;
  }
}
