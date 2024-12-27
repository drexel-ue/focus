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

/// A one-off task to be completed.
abstract class Task implements _i1.SerializableModel {
  Task._({
    this.id,
    this.createdAt,
    this.lastModifiedAt,
    required this.userId,
    required this.title,
    this.description,
    bool? completed,
    required this.abilityExpValues,
  }) : completed = completed ?? false;

  factory Task({
    int? id,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    required int userId,
    required String title,
    String? description,
    bool? completed,
    required List<_i2.AbilityExperienceValue> abilityExpValues,
  }) = _TaskImpl;

  factory Task.fromJson(Map<String, dynamic> jsonSerialization) {
    return Task(
      id: jsonSerialization['id'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      lastModifiedAt: jsonSerialization['lastModifiedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastModifiedAt']),
      userId: jsonSerialization['userId'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      completed: jsonSerialization['completed'] as bool,
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
  DateTime? createdAt;

  /// Timestamp of last update to database entry.
  DateTime? lastModifiedAt;

  /// [User] that created this task.
  int userId;

  /// Title.
  String title;

  /// Description.
  String? description;

  /// Is the task completed?
  bool completed;

  /// Collection of [ExperiencePointValue]s to be rewarded upon completion of this task.
  List<_i2.AbilityExperienceValue> abilityExpValues;

  Task copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    int? userId,
    String? title,
    String? description,
    bool? completed,
    List<_i2.AbilityExperienceValue>? abilityExpValues,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (lastModifiedAt != null) 'lastModifiedAt': lastModifiedAt?.toJson(),
      'userId': userId,
      'title': title,
      if (description != null) 'description': description,
      'completed': completed,
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

class _TaskImpl extends Task {
  _TaskImpl({
    int? id,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    required int userId,
    required String title,
    String? description,
    bool? completed,
    required List<_i2.AbilityExperienceValue> abilityExpValues,
  }) : super._(
          id: id,
          createdAt: createdAt,
          lastModifiedAt: lastModifiedAt,
          userId: userId,
          title: title,
          description: description,
          completed: completed,
          abilityExpValues: abilityExpValues,
        );

  @override
  Task copyWith({
    Object? id = _Undefined,
    Object? createdAt = _Undefined,
    Object? lastModifiedAt = _Undefined,
    int? userId,
    String? title,
    Object? description = _Undefined,
    bool? completed,
    List<_i2.AbilityExperienceValue>? abilityExpValues,
  }) {
    return Task(
      id: id is int? ? id : this.id,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      lastModifiedAt:
          lastModifiedAt is DateTime? ? lastModifiedAt : this.lastModifiedAt,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      completed: completed ?? this.completed,
      abilityExpValues: abilityExpValues ??
          this.abilityExpValues.map((e0) => e0.copyWith()).toList(),
    );
  }
}
