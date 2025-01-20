import 'package:focus_server/src/extensions/user_buff.dart';
import 'package:focus_server/src/extensions/user_debuff.dart';
import 'package:focus_server/src/generated/protocol.dart';
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

  /// Returns a new [UserAbilityStats] modified by [buffs].
  UserAbilityStats buffed(List<UserBuff> buffs) {
    var strength = strengthExp;
    var vitality = vitalityExp;
    var agility = agilityExp;
    var intelligence = intelligenceExp;
    var perception = perceptionExp;
    for (final buff in buffs) {
      if (buff.modifies.contains(Ability.strength)) {
        strength = (strength * buff.modifier).toInt();
      }
      if (buff.modifies.contains(Ability.vitality)) {
        vitality = (vitality * buff.modifier).toInt();
      }
      if (buff.modifies.contains(Ability.agility)) {
        agility = (agility * buff.modifier).toInt();
      }
      if (buff.modifies.contains(Ability.intelligence)) {
        intelligence = (intelligence * buff.modifier).toInt();
      }
      if (buff.modifies.contains(Ability.perception)) {
        perception = (perception * buff.modifier).toInt();
      }
    }
    return UserAbilityStats(
      strengthExp: strength.toInt(),
      vitalityExp: vitality.toInt(),
      agilityExp: agility.toInt(),
      intelligenceExp: intelligence.toInt(),
      perceptionExp: perception.toInt(),
    );
  }

  /// Returns a new [UserAbilityStats] modified by [debuff].
  UserAbilityStats debuffed(List<UserDebuff> debuff) {
    var strength = strengthExp;
    var vitality = vitalityExp;
    var agility = agilityExp;
    var intelligence = intelligenceExp;
    var perception = perceptionExp;
    for (final debuff in debuff) {
      if (debuff.modifies.contains(Ability.strength)) {
        strength = (strength / debuff.modifier).toInt();
      }
      if (debuff.modifies.contains(Ability.vitality)) {
        vitality = (vitality / debuff.modifier).toInt();
      }
      if (debuff.modifies.contains(Ability.agility)) {
        agility = (agility / debuff.modifier).toInt();
      }
      if (debuff.modifies.contains(Ability.intelligence)) {
        intelligence = (intelligence / debuff.modifier).toInt();
      }
      if (debuff.modifies.contains(Ability.perception)) {
        perception = (perception / debuff.modifier).toInt();
      }
    }
    return UserAbilityStats(
      strengthExp: strength.toInt(),
      vitalityExp: vitality.toInt(),
      agilityExp: agility.toInt(),
      intelligenceExp: intelligence.toInt(),
      perceptionExp: perception.toInt(),
    );
  }
}
