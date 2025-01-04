import 'dart:math' as math;

import 'package:focus_client/focus_client.dart';

typedef UserAbilityLevelWithRemainder = ({int level, double remainder});

extension UserAbilityStatsX on UserAbilityStats {
  static const _constant = 0.4;

  double _levelEquation(int exp) => _constant * math.sqrt(exp);

  int get userLevel {
    final strengthLevel = strengthLevelWithRemainger.level;
    final vitalityLevel = vitalityLevelWithRemainger.level;
    final agilityLevel = agilityLevelWithRemainger.level;
    final intelligenceLevel = intelligenceLevelWithRemainger.level;
    final perceptionLevel = perceptionLevelWithRemainger.level;
    return strengthLevel + vitalityLevel + agilityLevel + intelligenceLevel + perceptionLevel;
  }

  UserAbilityLevelWithRemainder get strengthLevelWithRemainger {
    final value = _levelEquation(strengthExp);
    return (level: value.floor(), remainder: value - value.floor());
  }

  UserAbilityLevelWithRemainder get vitalityLevelWithRemainger {
    final value = _levelEquation(vitalityExp);
    return (level: value.floor(), remainder: value - value.floor());
  }

  UserAbilityLevelWithRemainder get agilityLevelWithRemainger {
    final value = _levelEquation(agilityExp);
    return (level: value.floor(), remainder: value - value.floor());
  }

  UserAbilityLevelWithRemainder get intelligenceLevelWithRemainger {
    final value = _levelEquation(intelligenceExp);
    return (level: value.floor(), remainder: value - value.floor());
  }

  UserAbilityLevelWithRemainder get perceptionLevelWithRemainger {
    final value = _levelEquation(perceptionExp);
    return (level: value.floor(), remainder: value - value.floor());
  }

  int expFor(Ability ability) => switch (ability) {
        Ability.strength => strengthExp,
        Ability.vitality => vitalityExp,
        Ability.agility => agilityExp,
        Ability.intelligence => intelligenceExp,
        Ability.perception => perceptionExp,
      };
}
