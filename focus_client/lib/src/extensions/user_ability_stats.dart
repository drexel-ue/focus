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

  UserAbilityLevelWithRemainder _calculateLevelWithRemainder(int exp) {
    final value = _calculateLevel(exp);
    return (level: value.floor(), remainder: value - value.floor());
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
    return _calculateLevelWithRemainder(strengthExp);
  }

  UserAbilityLevelWithRemainder get vitalityLevelWithRemainger {
    return _calculateLevelWithRemainder(vitalityExp);
  }

  UserAbilityLevelWithRemainder get agilityLevelWithRemainger {
    return _calculateLevelWithRemainder(agilityExp);
  }

  UserAbilityLevelWithRemainder get intelligenceLevelWithRemainger {
    return _calculateLevelWithRemainder(intelligenceExp);
  }

  UserAbilityLevelWithRemainder get perceptionLevelWithRemainger {
    return _calculateLevelWithRemainder(perceptionExp);
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
