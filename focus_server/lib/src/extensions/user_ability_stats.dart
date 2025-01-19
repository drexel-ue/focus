import 'package:focus_server/src/generated/user_ability_stats.dart';

///
extension UserAbilityStatsX on UserAbilityStats {
  /// Returns a new [UserAbilityStats] with the sum of this and [other].
  UserAbilityStats operator +(UserAbilityStats other) {
    return UserAbilityStats(
      strengthExp: strengthExp + other.strengthExp,
      vitalityExp: vitalityExp + other.vitalityExp,
      agilityExp: agilityExp + other.agilityExp,
      intelligenceExp: intelligenceExp + other.intelligenceExp,
      perceptionExp: perceptionExp + other.perceptionExp,
    );
  }

  /// Returns a new [UserAbilityStats] with the difference of this and [other].
  UserAbilityStats operator -(UserAbilityStats other) {
    return UserAbilityStats(
      strengthExp: strengthExp - other.strengthExp,
      vitalityExp: vitalityExp - other.vitalityExp,
      agilityExp: agilityExp - other.agilityExp,
      intelligenceExp: intelligenceExp - other.intelligenceExp,
      perceptionExp: perceptionExp - other.perceptionExp,
    );
  }
}
