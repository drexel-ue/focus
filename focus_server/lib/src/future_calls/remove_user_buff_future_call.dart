import 'package:focus_server/src/extensions/user_buff.dart';
import 'package:focus_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Removes a [UserBuff].
class RemoveUserBuffFutureCall extends FutureCall<UserIdWithUserBuff> {
  /// Name.
  static const callName = 'removeUserBuff';

  /// Schedules a [UserBuff] to be removed.
  static Future<void> schedule(
    Session session,
    Transaction transaction,
    User user,
    UserBuff buff,
  ) async {
    return await session.db.transaction((Transaction transaction) async {
      final identifier = 'remove-user-buff-${user.id}-${buff.name}';
      await session.serverpod.cancelFutureCall(identifier);
      await session.serverpod.futureCallWithDelay(
        callName,
        UserIdWithUserBuff(userId: user.id!, buff: buff),
        buff.duration,
        identifier: identifier,
      );
    });
  }

  @override
  Future<void> invoke(Session session, UserIdWithUserBuff? object) async {
    return await session.db.transaction((Transaction transaction) async {
      final user = await User.db.findById(session, object!.userId, transaction: transaction);
      if (user == null) {
        throw NotFoundException(message: 'missing User');
      }
      user.buffs = user.buffs.where((buff) => buff != object.buff).toList();
      await User.db.updateRow(session, user, transaction: transaction);
    });
  }
}
