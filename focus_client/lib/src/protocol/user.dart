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
import 'user_ability_stats.dart' as _i2;
import 'user_buff.dart' as _i3;
import 'user_debuff.dart' as _i4;

/// User model.
abstract class User implements _i1.SerializableModel {
  User._({
    this.id,
    this.firstName,
    this.lastName,
    this.profileImageUrl,
    required this.abilityStats,
    required this.buffs,
    required this.debuffs,
  });

  factory User({
    int? id,
    String? firstName,
    String? lastName,
    String? profileImageUrl,
    required _i2.UserAbilityStats abilityStats,
    required List<_i3.UserBuff> buffs,
    required List<_i4.UserDebuff> debuffs,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      id: jsonSerialization['id'] as int?,
      firstName: jsonSerialization['firstName'] as String?,
      lastName: jsonSerialization['lastName'] as String?,
      profileImageUrl: jsonSerialization['profileImageUrl'] as String?,
      abilityStats: _i2.UserAbilityStats.fromJson(
          (jsonSerialization['abilityStats'] as Map<String, dynamic>)),
      buffs: (jsonSerialization['buffs'] as List)
          .map((e) => _i3.UserBuff.fromJson((e as int)))
          .toList(),
      debuffs: (jsonSerialization['debuffs'] as List)
          .map((e) => _i4.UserDebuff.fromJson((e as int)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// First name.
  String? firstName;

  /// Last name.
  String? lastName;

  /// Profile image url.
  String? profileImageUrl;

  /// [Ability] stats.
  _i2.UserAbilityStats abilityStats;

  /// Buffs.
  List<_i3.UserBuff> buffs;

  /// Debuffs.
  List<_i4.UserDebuff> debuffs;

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? profileImageUrl,
    _i2.UserAbilityStats? abilityStats,
    List<_i3.UserBuff>? buffs,
    List<_i4.UserDebuff>? debuffs,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      'abilityStats': abilityStats.toJson(),
      'buffs': buffs.toJson(valueToJson: (v) => v.toJson()),
      'debuffs': debuffs.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    String? firstName,
    String? lastName,
    String? profileImageUrl,
    required _i2.UserAbilityStats abilityStats,
    required List<_i3.UserBuff> buffs,
    required List<_i4.UserDebuff> debuffs,
  }) : super._(
          id: id,
          firstName: firstName,
          lastName: lastName,
          profileImageUrl: profileImageUrl,
          abilityStats: abilityStats,
          buffs: buffs,
          debuffs: debuffs,
        );

  @override
  User copyWith({
    Object? id = _Undefined,
    Object? firstName = _Undefined,
    Object? lastName = _Undefined,
    Object? profileImageUrl = _Undefined,
    _i2.UserAbilityStats? abilityStats,
    List<_i3.UserBuff>? buffs,
    List<_i4.UserDebuff>? debuffs,
  }) {
    return User(
      id: id is int? ? id : this.id,
      firstName: firstName is String? ? firstName : this.firstName,
      lastName: lastName is String? ? lastName : this.lastName,
      profileImageUrl:
          profileImageUrl is String? ? profileImageUrl : this.profileImageUrl,
      abilityStats: abilityStats ?? this.abilityStats.copyWith(),
      buffs: buffs ?? this.buffs.map((e0) => e0).toList(),
      debuffs: debuffs ?? this.debuffs.map((e0) => e0).toList(),
    );
  }
}
