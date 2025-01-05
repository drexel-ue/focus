import 'dart:math' as math;

import 'package:focus_client/focus_client.dart';

typedef UserAbilityLevelWithRemainder = ({int level, double remainder});

extension UserAbilityStatsX on UserAbilityStats {
  static final empty = UserAbilityStats(
    strengthExp: 0,
    vitalityExp: 0,
    agilityExp: 0,
    intelligenceExp: 0,
    perceptionExp: 0,
  );

  // Function to calculate the level based on experience points
  double _calculateLevel(int experience) {
    const double baseExp = 100; // Base experience for level 1
    const double growthFactor = 1.1; // 10% growth per level

    // Calculate level using logarithmic inversion
    double level =
        math.log(experience * (1 - growthFactor) / -baseExp + 1) / math.log(growthFactor);

    return level;
  }

  int get userLevel {
    final strengthLevel = strengthLevelWithRemainger.level;
    final vitalityLevel = vitalityLevelWithRemainger.level;
    final agilityLevel = agilityLevelWithRemainger.level;
    final intelligenceLevel = intelligenceLevelWithRemainger.level;
    final perceptionLevel = perceptionLevelWithRemainger.level;
    return strengthLevel + vitalityLevel + agilityLevel + intelligenceLevel + perceptionLevel;
  }

  UserAbilityLevelWithRemainder get strengthLevelWithRemainger {
    final value = _calculateLevel(strengthExp);
    return (level: value.floor(), remainder: value - value.floor());
  }

  UserAbilityLevelWithRemainder get vitalityLevelWithRemainger {
    final value = _calculateLevel(vitalityExp);
    return (level: value.floor(), remainder: value - value.floor());
  }

  UserAbilityLevelWithRemainder get agilityLevelWithRemainger {
    final value = _calculateLevel(agilityExp);
    return (level: value.floor(), remainder: value - value.floor());
  }

  UserAbilityLevelWithRemainder get intelligenceLevelWithRemainger {
    final value = _calculateLevel(intelligenceExp);
    return (level: value.floor(), remainder: value - value.floor());
  }

  UserAbilityLevelWithRemainder get perceptionLevelWithRemainger {
    final value = _calculateLevel(perceptionExp);
    return (level: value.floor(), remainder: value - value.floor());
  }

  UserAbilityLevelWithRemainder levelWithRemainderFor(Ability ability) => switch (ability) {
        Ability.strength => strengthLevelWithRemainger,
        Ability.vitality => vitalityLevelWithRemainger,
        Ability.agility => agilityLevelWithRemainger,
        Ability.intelligence => intelligenceLevelWithRemainger,
        Ability.perception => perceptionLevelWithRemainger,
      };

  int expFor(Ability ability) => switch (ability) {
        Ability.strength => strengthExp,
        Ability.vitality => vitalityExp,
        Ability.agility => agilityExp,
        Ability.intelligence => intelligenceExp,
        Ability.perception => perceptionExp,
      };

  UserAbilityStats operator +(UserAbilityStats other) {
    return UserAbilityStats(
      strengthExp: strengthExp + other.strengthExp,
      vitalityExp: vitalityExp + other.vitalityExp,
      agilityExp: agilityExp + other.agilityExp,
      intelligenceExp: intelligenceExp + other.intelligenceExp,
      perceptionExp: perceptionExp + other.perceptionExp,
    );
  }

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
