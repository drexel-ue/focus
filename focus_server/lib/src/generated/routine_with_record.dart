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
import 'routine.dart' as _i2;
import 'routine_record.dart' as _i3;

/// Wrapper class for a [Routine] and a [RoutineRecord].
abstract class RoutineWithRecord
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  RoutineWithRecord._({
    required this.routine,
    required this.record,
  });

  factory RoutineWithRecord({
    required _i2.Routine routine,
    required _i3.RoutineRecord record,
  }) = _RoutineWithRecordImpl;

  factory RoutineWithRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoutineWithRecord(
      routine: _i2.Routine.fromJson(
          (jsonSerialization['routine'] as Map<String, dynamic>)),
      record: _i3.RoutineRecord.fromJson(
          (jsonSerialization['record'] as Map<String, dynamic>)),
    );
  }

  /// [Routine].
  _i2.Routine routine;

  /// [RoutineRecord].
  _i3.RoutineRecord record;

  RoutineWithRecord copyWith({
    _i2.Routine? routine,
    _i3.RoutineRecord? record,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'routine': routine.toJson(),
      'record': record.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'routine': routine.toJsonForProtocol(),
      'record': record.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _RoutineWithRecordImpl extends RoutineWithRecord {
  _RoutineWithRecordImpl({
    required _i2.Routine routine,
    required _i3.RoutineRecord record,
  }) : super._(
          routine: routine,
          record: record,
        );

  @override
  RoutineWithRecord copyWith({
    _i2.Routine? routine,
    _i3.RoutineRecord? record,
  }) {
    return RoutineWithRecord(
      routine: routine ?? this.routine.copyWith(),
      record: record ?? this.record.copyWith(),
    );
  }
}
