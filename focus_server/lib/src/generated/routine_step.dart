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
import 'routine_step_type.dart' as _i2;
import 'user_ability_stats.dart' as _i3;

/// Step in a [Routine].
abstract class RoutineStep
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  RoutineStep._({
    required this.title,
    required this.type,
    this.duration,
    this.tally,
    int? repeats,
    required this.abilityExpValues,
  }) : repeats = repeats ?? 0;

  factory RoutineStep({
    required String title,
    required _i2.RoutineStepType type,
    Duration? duration,
    int? tally,
    int? repeats,
    required _i3.UserAbilityStats abilityExpValues,
  }) = _RoutineStepImpl;

  factory RoutineStep.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoutineStep(
      title: jsonSerialization['title'] as String,
      type: _i2.RoutineStepType.fromJson((jsonSerialization['type'] as String)),
      duration: jsonSerialization['duration'] == null
          ? null
          : _i1.DurationJsonExtension.fromJson(jsonSerialization['duration']),
      tally: jsonSerialization['tally'] as int?,
      repeats: jsonSerialization['repeats'] as int,
      abilityExpValues: _i3.UserAbilityStats.fromJson(
          (jsonSerialization['abilityExpValues'] as Map<String, dynamic>)),
    );
  }

  /// Title.
  String title;

  /// Type.
  _i2.RoutineStepType type;

  /// Optional [Duration] if type is [RoutineStepType.duration].
  Duration? duration;

  /// Optional tally if type is [RoutineStepType.tally].
  int? tally;

  /// How many times does this step repeat?
  int repeats;

  /// Collection of exp to be rewarded upon completion of this step.
  _i3.UserAbilityStats abilityExpValues;

  RoutineStep copyWith({
    String? title,
    _i2.RoutineStepType? type,
    Duration? duration,
    int? tally,
    int? repeats,
    _i3.UserAbilityStats? abilityExpValues,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type.toJson(),
      if (duration != null) 'duration': duration?.toJson(),
      if (tally != null) 'tally': tally,
      'repeats': repeats,
      'abilityExpValues': abilityExpValues.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'title': title,
      'type': type.toJson(),
      if (duration != null) 'duration': duration?.toJson(),
      if (tally != null) 'tally': tally,
      'repeats': repeats,
      'abilityExpValues': abilityExpValues.toJsonForProtocol(),
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
    required String title,
    required _i2.RoutineStepType type,
    Duration? duration,
    int? tally,
    int? repeats,
    required _i3.UserAbilityStats abilityExpValues,
  }) : super._(
          title: title,
          type: type,
          duration: duration,
          tally: tally,
          repeats: repeats,
          abilityExpValues: abilityExpValues,
        );

  @override
  RoutineStep copyWith({
    String? title,
    _i2.RoutineStepType? type,
    Object? duration = _Undefined,
    Object? tally = _Undefined,
    int? repeats,
    _i3.UserAbilityStats? abilityExpValues,
  }) {
    return RoutineStep(
      title: title ?? this.title,
      type: type ?? this.type,
      duration: duration is Duration? ? duration : this.duration,
      tally: tally is int? ? tally : this.tally,
      repeats: repeats ?? this.repeats,
      abilityExpValues: abilityExpValues ?? this.abilityExpValues.copyWith(),
    );
  }
}
