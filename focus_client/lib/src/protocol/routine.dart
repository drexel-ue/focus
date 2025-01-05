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
import 'user_buff.dart' as _i3;
import 'user_debuff.dart' as _i4;

/// A repeatable series of steps.
abstract class Routine implements _i1.SerializableModel {
  Routine._({
    this.id,
    required this.createdAt,
    required this.lastModifiedAt,
    required this.userId,
    required this.title,
    required this.steps,
    required this.buffs,
    required this.debuffs,
  });

  factory Routine({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required int userId,
    required String title,
    required List<_i2.RoutineStep> steps,
    required List<_i3.UserBuff> buffs,
    required List<_i4.UserDebuff> debuffs,
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
      steps: (jsonSerialization['steps'] as List)
          .map((e) => _i2.RoutineStep.fromJson((e as Map<String, dynamic>)))
          .toList(),
      buffs: (jsonSerialization['buffs'] as List)
          .map((e) => _i3.UserBuff.fromJson((e as int)))
          .toList(),
      debuffs: (jsonSerialization['debuffs'] as List)
          .map((e) => _i4.UserDebuff.fromJson((e as int)))
          .toList(),
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

  /// Title.
  String title;

  /// [RoutineStep]s to complete.
  List<_i2.RoutineStep> steps;

  /// [UserBuff]s awarded upon completion of this routine.
  List<_i3.UserBuff> buffs;

  /// [UserDebuff]s to apply upon failure to complete this routine within 24 hours of starting it.
  List<_i4.UserDebuff> debuffs;

  Routine copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    int? userId,
    String? title,
    List<_i2.RoutineStep>? steps,
    List<_i3.UserBuff>? buffs,
    List<_i4.UserDebuff>? debuffs,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'lastModifiedAt': lastModifiedAt.toJson(),
      'userId': userId,
      'title': title,
      'steps': steps.toJson(valueToJson: (v) => v.toJson()),
      'buffs': buffs.toJson(valueToJson: (v) => v.toJson()),
      'debuffs': debuffs.toJson(valueToJson: (v) => v.toJson()),
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
    required List<_i2.RoutineStep> steps,
    required List<_i3.UserBuff> buffs,
    required List<_i4.UserDebuff> debuffs,
  }) : super._(
          id: id,
          createdAt: createdAt,
          lastModifiedAt: lastModifiedAt,
          userId: userId,
          title: title,
          steps: steps,
          buffs: buffs,
          debuffs: debuffs,
        );

  @override
  Routine copyWith({
    Object? id = _Undefined,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    int? userId,
    String? title,
    List<_i2.RoutineStep>? steps,
    List<_i3.UserBuff>? buffs,
    List<_i4.UserDebuff>? debuffs,
  }) {
    return Routine(
      id: id is int? ? id : this.id,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      steps: steps ?? this.steps.map((e0) => e0.copyWith()).toList(),
      buffs: buffs ?? this.buffs.map((e0) => e0).toList(),
      debuffs: debuffs ?? this.debuffs.map((e0) => e0).toList(),
    );
  }
}
