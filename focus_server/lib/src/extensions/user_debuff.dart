import 'package:focus_server/src/generated/protocol.dart';

///
extension UserDebuffX on UserDebuff {
  /// How long this debuff should last.
  Duration get duration {
    return switch (this) {
      UserDebuff.fatigued => const Duration(hours: 16),
      UserDebuff.undisciplined => const Duration(hours: 24),
      UserDebuff.dunce => const Duration(hours: 4),
      UserDebuff.slacker => const Duration(hours: 2),
      UserDebuff.coldMuscle => const Duration(hours: 1),
    };
  }

  /// Multiplier for [AbilityStats].
  double get modifier {
    return switch (this) {
      UserDebuff.fatigued => 0.95,
      UserDebuff.undisciplined => 0.95,
      UserDebuff.dunce => 0.98,
      UserDebuff.slacker => 0.98,
      UserDebuff.coldMuscle => 0.98,
    };
  }

  /// Stats modified by this debuff.
  List<Ability> get modifies {
    return switch (this) {
      UserDebuff.fatigued => Ability.values,
      UserDebuff.undisciplined => Ability.values,
      UserDebuff.dunce => [Ability.intelligence],
      UserDebuff.slacker => [Ability.vitality],
      UserDebuff.coldMuscle => [Ability.agility, Ability.strength],
    };
  }
}
