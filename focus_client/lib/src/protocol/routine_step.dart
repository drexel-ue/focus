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
import 'ability_experience_value.dart' as _i2;

/// A par of a [Routine].
abstract class RoutineStep implements _i1.SerializableModel {
  RoutineStep._({
    this.id,
    required this.createdAt,
    required this.lastModifiedAt,
    required this.title,
    this.description,
    required this.abilityExpValues,
  });

  factory RoutineStep({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required String title,
    String? description,
    required List<_i2.AbilityExperienceValue> abilityExpValues,
  }) = _RoutineStepImpl;

  factory RoutineStep.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoutineStep(
      id: jsonSerialization['id'] as int?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      lastModifiedAt: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['lastModifiedAt']),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      abilityExpValues: (jsonSerialization['abilityExpValues'] as List)
          .map((e) =>
              _i2.AbilityExperienceValue.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Timestamp of entry into database.
  DateTime createdAt;

  /// Timestamp of last update to database entry.
  DateTime lastModifiedAt;

  /// Title.
  String title;

  /// Description.
  String? description;

  /// Collection of [ExperiencePointValue]s to be rewarded upon completion of this task.
  List<_i2.AbilityExperienceValue> abilityExpValues;

  RoutineStep copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    String? title,
    String? description,
    List<_i2.AbilityExperienceValue>? abilityExpValues,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'lastModifiedAt': lastModifiedAt.toJson(),
      'title': title,
      if (description != null) 'description': description,
      'abilityExpValues':
          abilityExpValues.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoutineStepImpl extends RoutineStep {
  _RoutineStepImpl({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required String title,
    String? description,
    required List<_i2.AbilityExperienceValue> abilityExpValues,
  }) : super._(
          id: id,
          createdAt: createdAt,
          lastModifiedAt: lastModifiedAt,
          title: title,
          description: description,
          abilityExpValues: abilityExpValues,
        );

  @override
  RoutineStep copyWith({
    Object? id = _Undefined,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    String? title,
    Object? description = _Undefined,
    List<_i2.AbilityExperienceValue>? abilityExpValues,
  }) {
    return RoutineStep(
      id: id is int? ? id : this.id,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      abilityExpValues: abilityExpValues ??
          this.abilityExpValues.map((e0) => e0.copyWith()).toList(),
    );
  }
}
