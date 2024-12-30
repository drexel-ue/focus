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
import 'routine_segment.dart' as _i3;

/// Repeatable sequence of [Step]s.
abstract class Routine implements _i1.SerializableModel {
  Routine._({
    this.id,
    required this.createdAt,
    required this.lastModifiedAt,
    required this.userId,
    required this.title,
    required this.active,
    this.steps,
    this.segments,
  });

  factory Routine({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required int userId,
    required String title,
    required bool active,
    List<_i2.RoutineStep>? steps,
    List<_i3.RoutineSegment>? segments,
  }) = _RoutineImpl;

  factory Routine.fromJson(Map<String, dynamic> jsonSerialization) {
    return Routine(
      id: jsonSerialization['id'] as int?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      lastModifiedAt: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['lastModifiedAt']),
      userId: jsonSerialization['userId'] as int,
      title: jsonSerialization['title'] as String,
      active: jsonSerialization['active'] as bool,
      steps: (jsonSerialization['steps'] as List?)
          ?.map((e) => _i2.RoutineStep.fromJson((e as Map<String, dynamic>)))
          .toList(),
      segments: (jsonSerialization['segments'] as List?)
          ?.map((e) => _i3.RoutineSegment.fromJson((e as Map<String, dynamic>)))
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

  /// Id of [User] that created this routine.
  int userId;

  /// Title.
  String title;

  /// Is this routine active?
  bool active;

  /// [Step]s of this routine.
  List<_i2.RoutineStep>? steps;

  /// Collection of steps.
  List<_i3.RoutineSegment>? segments;

  Routine copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    int? userId,
    String? title,
    bool? active,
    List<_i2.RoutineStep>? steps,
    List<_i3.RoutineSegment>? segments,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'lastModifiedAt': lastModifiedAt.toJson(),
      'userId': userId,
      'title': title,
      'active': active,
      if (steps != null) 'steps': steps?.toJson(valueToJson: (v) => v.toJson()),
      if (segments != null)
        'segments': segments?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoutineImpl extends Routine {
  _RoutineImpl({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required int userId,
    required String title,
    required bool active,
    List<_i2.RoutineStep>? steps,
    List<_i3.RoutineSegment>? segments,
  }) : super._(
          id: id,
          createdAt: createdAt,
          lastModifiedAt: lastModifiedAt,
          userId: userId,
          title: title,
          active: active,
          steps: steps,
          segments: segments,
        );

  @override
  Routine copyWith({
    Object? id = _Undefined,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    int? userId,
    String? title,
    bool? active,
    Object? steps = _Undefined,
    Object? segments = _Undefined,
  }) {
    return Routine(
      id: id is int? ? id : this.id,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      active: active ?? this.active,
      steps: steps is List<_i2.RoutineStep>?
          ? steps
          : this.steps?.map((e0) => e0.copyWith()).toList(),
      segments: segments is List<_i3.RoutineSegment>?
          ? segments
          : this.segments?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
