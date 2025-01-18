/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'user_debuff.dart' as _i2;

/// Wrapper class for a user id and a [UserDebuff].
abstract class UserIdWithUserDebuff
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  UserIdWithUserDebuff._({
    required this.userId,
    required this.debuff,
  });

  factory UserIdWithUserDebuff({
    required int userId,
    required _i2.UserDebuff debuff,
  }) = _UserIdWithUserDebuffImpl;

  factory UserIdWithUserDebuff.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return UserIdWithUserDebuff(
      userId: jsonSerialization['userId'] as int,
      debuff: _i2.UserDebuff.fromJson((jsonSerialization['debuff'] as int)),
    );
  }

  /// User id.
  int userId;

  /// [UserDebuff].
  _i2.UserDebuff debuff;

  UserIdWithUserDebuff copyWith({
    int? userId,
    _i2.UserDebuff? debuff,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'debuff': debuff.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'userId': userId,
      'debuff': debuff.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _UserIdWithUserDebuffImpl extends UserIdWithUserDebuff {
  _UserIdWithUserDebuffImpl({
    required int userId,
    required _i2.UserDebuff debuff,
  }) : super._(
          userId: userId,
          debuff: debuff,
        );

  @override
  UserIdWithUserDebuff copyWith({
    int? userId,
    _i2.UserDebuff? debuff,
  }) {
    return UserIdWithUserDebuff(
      userId: userId ?? this.userId,
      debuff: debuff ?? this.debuff,
    );
  }
}
