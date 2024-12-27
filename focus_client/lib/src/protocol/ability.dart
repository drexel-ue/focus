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

/// An upgradable aspect of the [User].
enum Ability implements _i1.SerializableModel {
  /// Physical power, physical work capacity, resistence, durability.
  strength,

  /// Capacity to grow, live, or develop. Vigor, endurance.
  vitality,

  /// Nimbleness, power of moving the limbs quickly and easily.
  agility,

  /// Ability to aquire, understand, and use knowledge.
  intelligence,

  /// Process of perceiving something with the senses. Capacity for insight.
  perception;

  static Ability fromJson(String name) {
    switch (name) {
      case 'strength':
        return strength;
      case 'vitality':
        return vitality;
      case 'agility':
        return agility;
      case 'intelligence':
        return intelligence;
      case 'perception':
        return perception;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "Ability"');
    }
  }

  @override
  String toJson() => name;
  @override
  String toString() => name;
}
