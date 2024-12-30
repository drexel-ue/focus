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
import 'routine_step.dart' as _i2;

/// A collection of [Step]s in a [Routine].
abstract class RoutineSegment implements _i1.SerializableModel {
  RoutineSegment._({
    this.id,
    required this.createdAt,
    required this.lastModifiedAt,
    required this.title,
    this.steps,
  });

  factory RoutineSegment({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required String title,
    List<_i2.RoutineStep>? steps,
  }) = _RoutineSegmentImpl;

  factory RoutineSegment.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoutineSegment(
      id: jsonSerialization['id'] as int?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      lastModifiedAt: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['lastModifiedAt']),
      title: jsonSerialization['title'] as String,
      steps: (jsonSerialization['steps'] as List?)
          ?.map((e) => _i2.RoutineStep.fromJson((e as Map<String, dynamic>)))
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

  /// [Step]s of this segment.
  List<_i2.RoutineStep>? steps;

  RoutineSegment copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    String? title,
    List<_i2.RoutineStep>? steps,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'lastModifiedAt': lastModifiedAt.toJson(),
      'title': title,
      if (steps != null) 'steps': steps?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoutineSegmentImpl extends RoutineSegment {
  _RoutineSegmentImpl({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required String title,
    List<_i2.RoutineStep>? steps,
  }) : super._(
          id: id,
          createdAt: createdAt,
          lastModifiedAt: lastModifiedAt,
          title: title,
          steps: steps,
        );

  @override
  RoutineSegment copyWith({
    Object? id = _Undefined,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    String? title,
    Object? steps = _Undefined,
  }) {
    return RoutineSegment(
      id: id is int? ? id : this.id,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      title: title ?? this.title,
      steps: steps is List<_i2.RoutineStep>?
          ? steps
          : this.steps?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
