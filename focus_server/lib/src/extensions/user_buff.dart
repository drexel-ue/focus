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
}
