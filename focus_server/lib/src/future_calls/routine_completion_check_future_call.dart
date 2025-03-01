import 'package:focus_server/src/extensions/user_debuff.dart';
import 'package:focus_server/src/future_calls/remove_user_debuff_future_call.dart';
import 'package:focus_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Checks if a [Routine] has been completed. If not, applies listed [UserDebuff]s.
class RoutineCompletionCheckFutureCall extends FutureCall<Routine> {
  /// Name.
  static const callName = 'routineCompletionCheckFutureCall';

  @override
  Future<void> invoke(Session session, Routine? object) async {
    return await session.db.transaction((Transaction transaction) async {
      try {
        if (object == null) {
          throw FutureCallException(message: 'missing Routine');
        }
        final record = await RoutineRecord.db.findFirstRow(
          session,
          transaction: transaction,
          where: (table) => table.routineId.equals(object.id!),
        );
        if (record == null) {
          throw NotFoundException(message: 'missing RoutineRecord');
        }
        if (record.status == RoutineRecordStatus.running) {
          final user = await User.db.findById(session, object.userId, transaction: transaction);
          if (user == null) {
            throw NotFoundException(message: 'missing User');
          }
          for (final debuff in object.debuffs) {
            final identifier = 'remove-user-debuff-${user.id}-${debuff.name}';
            await session.serverpod.cancelFutureCall(identifier);
            user.debuffs = {...user.debuffs, debuff}.toList();
            await session.serverpod.futureCallWithDelay(
              RemoveUserDebuffFutureCall.callName,
              UserIdWithUserDebuff(userId: user.id!, debuff: debuff),
              debuff.duration,
              identifier: identifier,
            );
          }
          await User.db.updateRow(session, user, transaction: transaction);
          record.status = RoutineRecordStatus.timedOut;
          await RoutineRecord.db.updateRow(session, record, transaction: transaction);
        }
      } catch (error, stackTrace) {
        session.log(
          'error in RoutineCompletionCheckFutureCall',
          level: LogLevel.error,
          exception: error,
          stackTrace: stackTrace,
        );
      }
    });
  }
}
