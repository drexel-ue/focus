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
