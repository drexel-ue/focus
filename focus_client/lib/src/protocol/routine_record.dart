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
import 'routine_record_status.dart' as _i2;

/// A record of a [User] interaction with a [Routine].
abstract class RoutineRecord implements _i1.SerializableModel {
  RoutineRecord._({
    this.id,
    required this.createdAt,
    required this.lastModifiedAt,
    required this.userId,
    required this.routineId,
    _i2.RoutineRecordStatus? status,
  }) : status = status ?? _i2.RoutineRecordStatus.running;

  factory RoutineRecord({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required int userId,
    required int routineId,
    _i2.RoutineRecordStatus? status,
  }) = _RoutineRecordImpl;

  factory RoutineRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoutineRecord(
      id: jsonSerialization['id'] as int?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      lastModifiedAt: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['lastModifiedAt']),
      userId: jsonSerialization['userId'] as int,
      routineId: jsonSerialization['routineId'] as int,
      status: _i2.RoutineRecordStatus.fromJson(
          (jsonSerialization['status'] as String)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Timestamp of model creation.
  DateTime createdAt;

  /// Timestamp of last update to database entry.
  DateTime lastModifiedAt;

  /// Id of the [User] that created this task.
  int userId;

  /// Id of the [Routine] this record is tracking.
  int routineId;

  /// Status.
  _i2.RoutineRecordStatus status;

  RoutineRecord copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    int? userId,
    int? routineId,
    _i2.RoutineRecordStatus? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'lastModifiedAt': lastModifiedAt.toJson(),
      'userId': userId,
      'routineId': routineId,
      'status': status.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoutineRecordImpl extends RoutineRecord {
  _RoutineRecordImpl({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required int userId,
    required int routineId,
    _i2.RoutineRecordStatus? status,
  }) : super._(
          id: id,
          createdAt: createdAt,
          lastModifiedAt: lastModifiedAt,
          userId: userId,
          routineId: routineId,
          status: status,
        );

  @override
  RoutineRecord copyWith({
    Object? id = _Undefined,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    int? userId,
    int? routineId,
    _i2.RoutineRecordStatus? status,
  }) {
    return RoutineRecord(
      id: id is int? ? id : this.id,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      userId: userId ?? this.userId,
      routineId: routineId ?? this.routineId,
      status: status ?? this.status,
    );
  }
}
