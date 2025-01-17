import 'package:focus_client/focus_client.dart';

extension RoutineX on Routine {
  /// Returns the combined [AbilityStats] for the [Routine].
  UserAbilityStats get stats {
    var stats = UserAbilityStats(
      strengthExp: 0,
      vitalityExp: 0,
      agilityExp: 0,
      intelligenceExp: 0,
      perceptionExp: 0,
    );
    for (final step in steps) {
      stats += step.abilityExpValues;
    }
    return stats;
  }
}
