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
}
