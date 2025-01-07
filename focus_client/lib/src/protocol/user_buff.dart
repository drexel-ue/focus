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

/// Positive modifiers for [Ability] exp gained.
enum UserBuff implements _i1.SerializableModel {
  /// The [User] is well rested. +2% to perception and intelligence exp gain.
  rested,

  /// The [User] has completed a physical warmup. +2% to strength and agility exp gain.
  warmedUp,

  /// The [User] has completed at least one [Routine] everyday for the past week. +5% to all exp gain.
  disciplined,

  /// The [User] has studied an intellectual subject. +2% to intelligence exp gain.
  studied,

  /// The [User] has completed physical training. +2% to vitality exp gain.
  trained;

  static UserBuff fromJson(int index) {
    switch (index) {
      case 0:
        return rested;
      case 1:
        return warmedUp;
      case 2:
        return disciplined;
      case 3:
        return studied;
      case 4:
        return trained;
      default:
        throw ArgumentError('Value "$index" cannot be converted to "UserBuff"');
    }
  }

  @override
  int toJson() => index;
  @override
  String toString() => name;
}
