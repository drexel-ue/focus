/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'user.dart' as _i2;
import 'routine_record.dart' as _i3;

/// Wrapper class for a [User] and a [RoutineRecord].
abstract class UserWithRoutineRecord implements _i1.SerializableModel {
  UserWithRoutineRecord._({
    required this.user,
    required this.record,
  });

  factory UserWithRoutineRecord({
    required _i2.User user,
    required _i3.RoutineRecord record,
  }) = _UserWithRoutineRecordImpl;

  factory UserWithRoutineRecord.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return UserWithRoutineRecord(
      user: _i2.User.fromJson(
          (jsonSerialization['user'] as Map<String, dynamic>)),
      record: _i3.RoutineRecord.fromJson(
          (jsonSerialization['record'] as Map<String, dynamic>)),
    );
  }

  /// [User].
  _i2.User user;

  /// [RoutineRecord].
  _i3.RoutineRecord record;

  UserWithRoutineRecord copyWith({
    _i2.User? user,
    _i3.RoutineRecord? record,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'record': record.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _UserWithRoutineRecordImpl extends UserWithRoutineRecord {
  _UserWithRoutineRecordImpl({
    required _i2.User user,
    required _i3.RoutineRecord record,
  }) : super._(
          user: user,
          record: record,
        );

  @override
  UserWithRoutineRecord copyWith({
    _i2.User? user,
    _i3.RoutineRecord? record,
  }) {
    return UserWithRoutineRecord(
      user: user ?? this.user.copyWith(),
      record: record ?? this.record.copyWith(),
    );
  }
}
