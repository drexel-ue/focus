import 'package:focus_server/src/extensions/user_debuff.dart';
import 'package:focus_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Removes a [UserDebuff].
class RemoveUserDebuffFutureCall extends FutureCall<UserIdWithUserDebuff> {
  /// Name.
  static const callName = 'removeUserDebuff';

  /// Schedules a [UserDebuff] to be removed.
  static Future<void> schedule(
    Session session,
    Transaction transaction,
    User user,
    UserDebuff debuff,
  ) async {
    return await session.db.transaction((Transaction transaction) async {
      final identifier = 'remove-user-debuff-${user.id}-${debuff.name}';
      await session.serverpod.cancelFutureCall(identifier);
      await session.serverpod.futureCallWithDelay(
        callName,
        UserIdWithUserDebuff(userId: user.id!, debuff: debuff),
        debuff.duration,
        identifier: identifier,
      );
    });
  }

  @override
  Future<void> invoke(Session session, UserIdWithUserDebuff? object) async {
    return await session.db.transaction((Transaction transaction) async {
      final user = await User.db.findById(session, object!.userId, transaction: transaction);
      if (user == null) {
        throw NotFoundException(message: 'missing User');
      }
      user.debuffs = user.debuffs.where((debuff) => debuff != object.debuff).toList();
      await User.db.updateRow(session, user, transaction: transaction);
    });
  }
}
