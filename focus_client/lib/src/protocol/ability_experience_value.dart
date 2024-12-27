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
import 'ability.dart' as _i2;

/// A model tracking experience gained toward a specific [Ability].
abstract class AbilityExperienceValue implements _i1.SerializableModel {
  AbilityExperienceValue._({
    required this.ability,
    required this.exp,
  });

  factory AbilityExperienceValue({
    required _i2.Ability ability,
    required int exp,
  }) = _AbilityExperienceValueImpl;

  factory AbilityExperienceValue.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return AbilityExperienceValue(
      ability: _i2.Ability.fromJson((jsonSerialization['ability'] as String)),
      exp: jsonSerialization['exp'] as int,
    );
  }

  /// The ability.
  _i2.Ability ability;

  /// Experience points to be earned.
  int exp;

  AbilityExperienceValue copyWith({
    _i2.Ability? ability,
    int? exp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'ability': ability.toJson(),
      'exp': exp,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AbilityExperienceValueImpl extends AbilityExperienceValue {
  _AbilityExperienceValueImpl({
    required _i2.Ability ability,
    required int exp,
  }) : super._(
          ability: ability,
          exp: exp,
        );

  @override
  AbilityExperienceValue copyWith({
    _i2.Ability? ability,
    int? exp,
  }) {
    return AbilityExperienceValue(
      ability: ability ?? this.ability,
      exp: exp ?? this.exp,
    );
  }
}
