import 'package:focus_server/src/extensions/user_ability_stats.dart';
import 'package:focus_server/src/generated/protocol.dart';

///
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
      stats = stats + step.abilityExpValues;
    }
    return stats;
  }
}
