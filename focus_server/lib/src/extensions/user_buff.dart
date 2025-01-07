import 'package:focus_server/src/generated/protocol.dart';

///
extension UserBuffX on UserBuff {
  /// How long this buff should last.
  Duration get duration {
    return switch (this) {
      UserBuff.rested => const Duration(hours: 16),
      // TODO: Handle this case.
      UserBuff.warmedUp => throw UnimplementedError(),
      // TODO: Handle this case.
      UserBuff.disciplined => throw UnimplementedError(),
      // TODO: Handle this case.
      UserBuff.studied => throw UnimplementedError(),
      // TODO: Handle this case.
      UserBuff.trained => throw UnimplementedError(),
    };
  }
}
