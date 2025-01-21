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
import '../user_ability_stats.dart' as _i2;
import '../routine.dart' as _i3;

/// Completion stats for a [User]'s [Routine]s.
abstract class RoutineStats implements _i1.SerializableModel {
  RoutineStats._({
    required this.completedStats,
    required this.abortedStats,
    required this.timedOutStats,
    this.mostRecentCompleted,
    this.mostRecentAborted,
    this.mostRecentTimedOut,
    this.mostFrequentCompleted,
    this.mostFrequentAborted,
    this.mostFrequentTimedOut,
  });

  factory RoutineStats({
    required _i2.UserAbilityStats completedStats,
    required _i2.UserAbilityStats abortedStats,
    required _i2.UserAbilityStats timedOutStats,
    _i3.Routine? mostRecentCompleted,
    _i3.Routine? mostRecentAborted,
    _i3.Routine? mostRecentTimedOut,
    _i3.Routine? mostFrequentCompleted,
    _i3.Routine? mostFrequentAborted,
    _i3.Routine? mostFrequentTimedOut,
  }) = _RoutineStatsImpl;

  factory RoutineStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoutineStats(
      completedStats: _i2.UserAbilityStats.fromJson(
          (jsonSerialization['completedStats'] as Map<String, dynamic>)),
      abortedStats: _i2.UserAbilityStats.fromJson(
          (jsonSerialization['abortedStats'] as Map<String, dynamic>)),
      timedOutStats: _i2.UserAbilityStats.fromJson(
          (jsonSerialization['timedOutStats'] as Map<String, dynamic>)),
      mostRecentCompleted: jsonSerialization['mostRecentCompleted'] == null
          ? null
          : _i3.Routine.fromJson((jsonSerialization['mostRecentCompleted']
              as Map<String, dynamic>)),
      mostRecentAborted: jsonSerialization['mostRecentAborted'] == null
          ? null
          : _i3.Routine.fromJson(
              (jsonSerialization['mostRecentAborted'] as Map<String, dynamic>)),
      mostRecentTimedOut: jsonSerialization['mostRecentTimedOut'] == null
          ? null
          : _i3.Routine.fromJson((jsonSerialization['mostRecentTimedOut']
              as Map<String, dynamic>)),
      mostFrequentCompleted: jsonSerialization['mostFrequentCompleted'] == null
          ? null
          : _i3.Routine.fromJson((jsonSerialization['mostFrequentCompleted']
              as Map<String, dynamic>)),
      mostFrequentAborted: jsonSerialization['mostFrequentAborted'] == null
          ? null
          : _i3.Routine.fromJson((jsonSerialization['mostFrequentAborted']
              as Map<String, dynamic>)),
      mostFrequentTimedOut: jsonSerialization['mostFrequentTimedOut'] == null
          ? null
          : _i3.Routine.fromJson((jsonSerialization['mostFrequentTimedOut']
              as Map<String, dynamic>)),
    );
  }

  /// Sum of [UserAbilityStats] for completed [Routine]s.
  _i2.UserAbilityStats completedStats;

  /// Sum of [UserAbilityStats] for aborted [Routine]s.
  _i2.UserAbilityStats abortedStats;

  /// Sum of [UserAbilityStats] for timed out [Routine]s.
  _i2.UserAbilityStats timedOutStats;

  /// Most recent [Routine] completed.
  _i3.Routine? mostRecentCompleted;

  /// Most recent [Routine] aborted.
  _i3.Routine? mostRecentAborted;

  /// Most recent [Routine] timed out.
  _i3.Routine? mostRecentTimedOut;

  /// Most frequent [Routine] completed.
  _i3.Routine? mostFrequentCompleted;

  /// Most frequent [Routine] aborted.
  _i3.Routine? mostFrequentAborted;

  /// Most frequent [Routine] timed out.
  _i3.Routine? mostFrequentTimedOut;

  RoutineStats copyWith({
    _i2.UserAbilityStats? completedStats,
    _i2.UserAbilityStats? abortedStats,
    _i2.UserAbilityStats? timedOutStats,
    _i3.Routine? mostRecentCompleted,
    _i3.Routine? mostRecentAborted,
    _i3.Routine? mostRecentTimedOut,
    _i3.Routine? mostFrequentCompleted,
    _i3.Routine? mostFrequentAborted,
    _i3.Routine? mostFrequentTimedOut,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'completedStats': completedStats.toJson(),
      'abortedStats': abortedStats.toJson(),
      'timedOutStats': timedOutStats.toJson(),
      if (mostRecentCompleted != null)
        'mostRecentCompleted': mostRecentCompleted?.toJson(),
      if (mostRecentAborted != null)
        'mostRecentAborted': mostRecentAborted?.toJson(),
      if (mostRecentTimedOut != null)
        'mostRecentTimedOut': mostRecentTimedOut?.toJson(),
      if (mostFrequentCompleted != null)
        'mostFrequentCompleted': mostFrequentCompleted?.toJson(),
      if (mostFrequentAborted != null)
        'mostFrequentAborted': mostFrequentAborted?.toJson(),
      if (mostFrequentTimedOut != null)
        'mostFrequentTimedOut': mostFrequentTimedOut?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoutineStatsImpl extends RoutineStats {
  _RoutineStatsImpl({
    required _i2.UserAbilityStats completedStats,
    required _i2.UserAbilityStats abortedStats,
    required _i2.UserAbilityStats timedOutStats,
    _i3.Routine? mostRecentCompleted,
    _i3.Routine? mostRecentAborted,
    _i3.Routine? mostRecentTimedOut,
    _i3.Routine? mostFrequentCompleted,
    _i3.Routine? mostFrequentAborted,
    _i3.Routine? mostFrequentTimedOut,
  }) : super._(
          completedStats: completedStats,
          abortedStats: abortedStats,
          timedOutStats: timedOutStats,
          mostRecentCompleted: mostRecentCompleted,
          mostRecentAborted: mostRecentAborted,
          mostRecentTimedOut: mostRecentTimedOut,
          mostFrequentCompleted: mostFrequentCompleted,
          mostFrequentAborted: mostFrequentAborted,
          mostFrequentTimedOut: mostFrequentTimedOut,
        );

  @override
  RoutineStats copyWith({
    _i2.UserAbilityStats? completedStats,
    _i2.UserAbilityStats? abortedStats,
    _i2.UserAbilityStats? timedOutStats,
    Object? mostRecentCompleted = _Undefined,
    Object? mostRecentAborted = _Undefined,
    Object? mostRecentTimedOut = _Undefined,
    Object? mostFrequentCompleted = _Undefined,
    Object? mostFrequentAborted = _Undefined,
    Object? mostFrequentTimedOut = _Undefined,
  }) {
    return RoutineStats(
      completedStats: completedStats ?? this.completedStats.copyWith(),
      abortedStats: abortedStats ?? this.abortedStats.copyWith(),
      timedOutStats: timedOutStats ?? this.timedOutStats.copyWith(),
      mostRecentCompleted: mostRecentCompleted is _i3.Routine?
          ? mostRecentCompleted
          : this.mostRecentCompleted?.copyWith(),
      mostRecentAborted: mostRecentAborted is _i3.Routine?
          ? mostRecentAborted
          : this.mostRecentAborted?.copyWith(),
      mostRecentTimedOut: mostRecentTimedOut is _i3.Routine?
          ? mostRecentTimedOut
          : this.mostRecentTimedOut?.copyWith(),
      mostFrequentCompleted: mostFrequentCompleted is _i3.Routine?
          ? mostFrequentCompleted
          : this.mostFrequentCompleted?.copyWith(),
      mostFrequentAborted: mostFrequentAborted is _i3.Routine?
          ? mostFrequentAborted
          : this.mostFrequentAborted?.copyWith(),
      mostFrequentTimedOut: mostFrequentTimedOut is _i3.Routine?
          ? mostFrequentTimedOut
          : this.mostFrequentTimedOut?.copyWith(),
    );
  }
}
