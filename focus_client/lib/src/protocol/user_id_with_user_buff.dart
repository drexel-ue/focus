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
import 'user_buff.dart' as _i2;

/// Wrapper class for a user id and a [UserBuff].
abstract class UserIdWithUserBuff implements _i1.SerializableModel {
  UserIdWithUserBuff._({
    required this.userId,
    required this.buff,
  });

  factory UserIdWithUserBuff({
    required int userId,
    required _i2.UserBuff buff,
  }) = _UserIdWithUserBuffImpl;

  factory UserIdWithUserBuff.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserIdWithUserBuff(
      userId: jsonSerialization['userId'] as int,
      buff: _i2.UserBuff.fromJson((jsonSerialization['buff'] as int)),
    );
  }

  /// User id.
  int userId;

  /// [UserBuff].
  _i2.UserBuff buff;

  UserIdWithUserBuff copyWith({
    int? userId,
    _i2.UserBuff? buff,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'buff': buff.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _UserIdWithUserBuffImpl extends UserIdWithUserBuff {
  _UserIdWithUserBuffImpl({
    required int userId,
    required _i2.UserBuff buff,
  }) : super._(
          userId: userId,
          buff: buff,
        );

  @override
  UserIdWithUserBuff copyWith({
    int? userId,
    _i2.UserBuff? buff,
  }) {
    return UserIdWithUserBuff(
      userId: userId ?? this.userId,
      buff: buff ?? this.buff,
    );
  }
}
