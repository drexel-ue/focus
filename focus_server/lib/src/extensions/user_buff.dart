import 'package:focus_server/src/generated/protocol.dart';

///
extension UserBuffX on UserBuff {
  /// How long this buff should last.
  Duration get duration {
    return switch (this) {
      UserBuff.rested => const Duration(hours: 16),
      UserBuff.warmedUp => const Duration(hours: 2),
      UserBuff.disciplined => const Duration(hours: 24),
      UserBuff.studied => const Duration(hours: 4),
      UserBuff.trained => const Duration(hours: 8),
    };
  }

  /// Multiplier for [AbilityStats].
  double get modifier {
    return switch (this) {
      UserBuff.rested => 1.02,
      UserBuff.warmedUp => 1.02,
      UserBuff.disciplined => 1.05,
      UserBuff.studied => 1.02,
      UserBuff.trained => 1.02,
    };
  }

  /// Stats modified by this buff.
  List<Ability> get modifies {
    return switch (this) {
      UserBuff.rested => [Ability.intelligence, Ability.perception],
      UserBuff.warmedUp => [Ability.agility, Ability.strength],
      UserBuff.disciplined => Ability.values,
      UserBuff.studied => [Ability.intelligence],
      UserBuff.trained => [Ability.vitality],
    };
  }
}
