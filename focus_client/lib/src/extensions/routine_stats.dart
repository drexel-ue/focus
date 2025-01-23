import 'package:focus_client/focus_client.dart';

extension RoutineStatsX on RoutineStats {
  /// Returns all [Routines] referenced by this [RoutineStats].
  List<Routine> get routines => shortestCompletionTime.keys.toList();

  /// Returns the [UserAbilityStats] for all completed [Routine]s.
  UserAbilityStats get completedStats {
    var stats = UserAbilityStats(
      strengthExp: 0,
      vitalityExp: 0,
      agilityExp: 0,
      intelligenceExp: 0,
      perceptionExp: 0,
    );
    for (final routine in routines) {
      stats += routine.stats;
    }
    return stats;
  }
}
