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

/// [Ability] stats for a given [User].
abstract class UserAbilityStats implements _i1.SerializableModel {
  UserAbilityStats._({
    required this.strengthExp,
    required this.vitalityExp,
    required this.agilityExp,
    required this.intelligenceExp,
    required this.perceptionExp,
  });

  factory UserAbilityStats({
    required int strengthExp,
    required int vitalityExp,
    required int agilityExp,
    required int intelligenceExp,
    required int perceptionExp,
  }) = _UserAbilityStatsImpl;

  factory UserAbilityStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserAbilityStats(
      strengthExp: jsonSerialization['strengthExp'] as int,
      vitalityExp: jsonSerialization['vitalityExp'] as int,
      agilityExp: jsonSerialization['agilityExp'] as int,
      intelligenceExp: jsonSerialization['intelligenceExp'] as int,
      perceptionExp: jsonSerialization['perceptionExp'] as int,
    );
  }

  /// Strength [Ability] exp.
  int strengthExp;

  /// Vitality [Ability] exp.
  int vitalityExp;

  /// Agility [Ability] exp.
  int agilityExp;

  /// Intelligence [Ability] exp.
  int intelligenceExp;

  /// Perception [Ability] exp.
  int perceptionExp;

  UserAbilityStats copyWith({
    int? strengthExp,
    int? vitalityExp,
    int? agilityExp,
    int? intelligenceExp,
    int? perceptionExp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'strengthExp': strengthExp,
      'vitalityExp': vitalityExp,
      'agilityExp': agilityExp,
      'intelligenceExp': intelligenceExp,
      'perceptionExp': perceptionExp,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _UserAbilityStatsImpl extends UserAbilityStats {
  _UserAbilityStatsImpl({
    required int strengthExp,
    required int vitalityExp,
    required int agilityExp,
    required int intelligenceExp,
    required int perceptionExp,
  }) : super._(
          strengthExp: strengthExp,
          vitalityExp: vitalityExp,
          agilityExp: agilityExp,
          intelligenceExp: intelligenceExp,
          perceptionExp: perceptionExp,
        );

  @override
  UserAbilityStats copyWith({
    int? strengthExp,
    int? vitalityExp,
    int? agilityExp,
    int? intelligenceExp,
    int? perceptionExp,
  }) {
    return UserAbilityStats(
      strengthExp: strengthExp ?? this.strengthExp,
      vitalityExp: vitalityExp ?? this.vitalityExp,
      agilityExp: agilityExp ?? this.agilityExp,
      intelligenceExp: intelligenceExp ?? this.intelligenceExp,
      perceptionExp: perceptionExp ?? this.perceptionExp,
    );
  }
}
