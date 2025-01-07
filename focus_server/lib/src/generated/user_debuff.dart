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

/// Negative modifiers for [Ability] exp gained.
enum UserDebuff implements _i1.SerializableModel {
  /// The [User] is not well rested. -5% to all exp gain.
  fatigued,

  /// The [User] has failed to complete a [Task] or [Routine] in the past 3 days. -5% to all exp gain.
  undisciplined,

  /// The [User] has failed to complete an intelligence based [Task] or [Routine] in the past 3 days. -2% to intelligence exp gain.
  dunce,

  /// The [User] has failed to complete a strength or agility based [Task] or [Routine] in the past 3 days. -2% to vitality exp gain.
  slacker,

  /// The [User] has failed to complete a warm up. -2% to strength and agility exp gain.
  coldMuscle;

  static UserDebuff fromJson(int index) {
    switch (index) {
      case 0:
        return fatigued;
      case 1:
        return undisciplined;
      case 2:
        return dunce;
      case 3:
        return slacker;
      case 4:
        return coldMuscle;
      default:
        throw ArgumentError(
            'Value "$index" cannot be converted to "UserDebuff"');
    }
  }

  @override
  int toJson() => index;
  @override
  String toString() => name;
}
