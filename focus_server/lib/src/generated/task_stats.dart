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
import 'user_ability_stats.dart' as _i2;
import 'task.dart' as _i3;

/// Completion stats for a [User]'s [Task]s.
abstract class TaskStats
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  TaskStats._({
    required this.completedStats,
    required this.incompleteStats,
    required this.completedTally,
    required this.incompleteTally,
    required this.averageCompletionTime,
    required this.longestCompletionTime,
    required this.shortestCompletionTime,
    required this.longestRunningTaskTime,
    this.longestCompletedTask,
    this.longestIncompleteTask,
    this.shortestCompletedTask,
  });

  factory TaskStats({
    required _i2.UserAbilityStats completedStats,
    required _i2.UserAbilityStats incompleteStats,
    required int completedTally,
    required int incompleteTally,
    required Duration averageCompletionTime,
    required Duration longestCompletionTime,
    required Duration shortestCompletionTime,
    required Duration longestRunningTaskTime,
    _i3.Task? longestCompletedTask,
    _i3.Task? longestIncompleteTask,
    _i3.Task? shortestCompletedTask,
  }) = _TaskStatsImpl;

  factory TaskStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return TaskStats(
      completedStats: _i2.UserAbilityStats.fromJson(
          (jsonSerialization['completedStats'] as Map<String, dynamic>)),
      incompleteStats: _i2.UserAbilityStats.fromJson(
          (jsonSerialization['incompleteStats'] as Map<String, dynamic>)),
      completedTally: jsonSerialization['completedTally'] as int,
      incompleteTally: jsonSerialization['incompleteTally'] as int,
      averageCompletionTime: _i1.DurationJsonExtension.fromJson(
          jsonSerialization['averageCompletionTime']),
      longestCompletionTime: _i1.DurationJsonExtension.fromJson(
          jsonSerialization['longestCompletionTime']),
      shortestCompletionTime: _i1.DurationJsonExtension.fromJson(
          jsonSerialization['shortestCompletionTime']),
      longestRunningTaskTime: _i1.DurationJsonExtension.fromJson(
          jsonSerialization['longestRunningTaskTime']),
      longestCompletedTask: jsonSerialization['longestCompletedTask'] == null
          ? null
          : _i3.Task.fromJson((jsonSerialization['longestCompletedTask']
              as Map<String, dynamic>)),
      longestIncompleteTask: jsonSerialization['longestIncompleteTask'] == null
          ? null
          : _i3.Task.fromJson((jsonSerialization['longestIncompleteTask']
              as Map<String, dynamic>)),
      shortestCompletedTask: jsonSerialization['shortestCompletedTask'] == null
          ? null
          : _i3.Task.fromJson((jsonSerialization['shortestCompletedTask']
              as Map<String, dynamic>)),
    );
  }

  /// Sum of [UserAbilityStats] for completed [Task]s.
  _i2.UserAbilityStats completedStats;

  /// Sum of [UserAbilityStats] for incomplete [Task]s.
  _i2.UserAbilityStats incompleteStats;

  /// Tally of completed [Task]s.
  int completedTally;

  /// Tally of incomplete [Task]s.
  int incompleteTally;

  /// Avertage completion time.
  Duration averageCompletionTime;

  /// Longest completion time.
  Duration longestCompletionTime;

  /// Shortest completion time.
  Duration shortestCompletionTime;

  /// Longest running task time.
  Duration longestRunningTaskTime;

  /// Longest completed [Task].
  _i3.Task? longestCompletedTask;

  /// Longest incomplete [Task].
  _i3.Task? longestIncompleteTask;

  /// Shortest completed [Task].
  _i3.Task? shortestCompletedTask;

  TaskStats copyWith({
    _i2.UserAbilityStats? completedStats,
    _i2.UserAbilityStats? incompleteStats,
    int? completedTally,
    int? incompleteTally,
    Duration? averageCompletionTime,
    Duration? longestCompletionTime,
    Duration? shortestCompletionTime,
    Duration? longestRunningTaskTime,
    _i3.Task? longestCompletedTask,
    _i3.Task? longestIncompleteTask,
    _i3.Task? shortestCompletedTask,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'completedStats': completedStats.toJson(),
      'incompleteStats': incompleteStats.toJson(),
      'completedTally': completedTally,
      'incompleteTally': incompleteTally,
      'averageCompletionTime': averageCompletionTime.toJson(),
      'longestCompletionTime': longestCompletionTime.toJson(),
      'shortestCompletionTime': shortestCompletionTime.toJson(),
      'longestRunningTaskTime': longestRunningTaskTime.toJson(),
      if (longestCompletedTask != null)
        'longestCompletedTask': longestCompletedTask?.toJson(),
      if (longestIncompleteTask != null)
        'longestIncompleteTask': longestIncompleteTask?.toJson(),
      if (shortestCompletedTask != null)
        'shortestCompletedTask': shortestCompletedTask?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'completedStats': completedStats.toJsonForProtocol(),
      'incompleteStats': incompleteStats.toJsonForProtocol(),
      'completedTally': completedTally,
      'incompleteTally': incompleteTally,
      'averageCompletionTime': averageCompletionTime.toJson(),
      'longestCompletionTime': longestCompletionTime.toJson(),
      'shortestCompletionTime': shortestCompletionTime.toJson(),
      'longestRunningTaskTime': longestRunningTaskTime.toJson(),
      if (longestCompletedTask != null)
        'longestCompletedTask': longestCompletedTask?.toJsonForProtocol(),
      if (longestIncompleteTask != null)
        'longestIncompleteTask': longestIncompleteTask?.toJsonForProtocol(),
      if (shortestCompletedTask != null)
        'shortestCompletedTask': shortestCompletedTask?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TaskStatsImpl extends TaskStats {
  _TaskStatsImpl({
    required _i2.UserAbilityStats completedStats,
    required _i2.UserAbilityStats incompleteStats,
    required int completedTally,
    required int incompleteTally,
    required Duration averageCompletionTime,
    required Duration longestCompletionTime,
    required Duration shortestCompletionTime,
    required Duration longestRunningTaskTime,
    _i3.Task? longestCompletedTask,
    _i3.Task? longestIncompleteTask,
    _i3.Task? shortestCompletedTask,
  }) : super._(
          completedStats: completedStats,
          incompleteStats: incompleteStats,
          completedTally: completedTally,
          incompleteTally: incompleteTally,
          averageCompletionTime: averageCompletionTime,
          longestCompletionTime: longestCompletionTime,
          shortestCompletionTime: shortestCompletionTime,
          longestRunningTaskTime: longestRunningTaskTime,
          longestCompletedTask: longestCompletedTask,
          longestIncompleteTask: longestIncompleteTask,
          shortestCompletedTask: shortestCompletedTask,
        );

  @override
  TaskStats copyWith({
    _i2.UserAbilityStats? completedStats,
    _i2.UserAbilityStats? incompleteStats,
    int? completedTally,
    int? incompleteTally,
    Duration? averageCompletionTime,
    Duration? longestCompletionTime,
    Duration? shortestCompletionTime,
    Duration? longestRunningTaskTime,
    Object? longestCompletedTask = _Undefined,
    Object? longestIncompleteTask = _Undefined,
    Object? shortestCompletedTask = _Undefined,
  }) {
    return TaskStats(
      completedStats: completedStats ?? this.completedStats.copyWith(),
      incompleteStats: incompleteStats ?? this.incompleteStats.copyWith(),
      completedTally: completedTally ?? this.completedTally,
      incompleteTally: incompleteTally ?? this.incompleteTally,
      averageCompletionTime:
          averageCompletionTime ?? this.averageCompletionTime,
      longestCompletionTime:
          longestCompletionTime ?? this.longestCompletionTime,
      shortestCompletionTime:
          shortestCompletionTime ?? this.shortestCompletionTime,
      longestRunningTaskTime:
          longestRunningTaskTime ?? this.longestRunningTaskTime,
      longestCompletedTask: longestCompletedTask is _i3.Task?
          ? longestCompletedTask
          : this.longestCompletedTask?.copyWith(),
      longestIncompleteTask: longestIncompleteTask is _i3.Task?
          ? longestIncompleteTask
          : this.longestIncompleteTask?.copyWith(),
      shortestCompletedTask: shortestCompletedTask is _i3.Task?
          ? shortestCompletedTask
          : this.shortestCompletedTask?.copyWith(),
    );
  }
}
