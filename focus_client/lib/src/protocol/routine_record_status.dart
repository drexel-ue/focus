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

/// The status of a [RoutineRecord].
enum RoutineRecordStatus implements _i1.SerializableModel {
  /// The [Routine] is currently running.
  running,

  /// The [Routine] was completed.
  completed,

  /// The [Routine] was aborted by the user.
  aborted,

  /// The [Routine] was not completed within 24 hours.
  timedOut;

  static RoutineRecordStatus fromJson(String name) {
    switch (name) {
      case 'running':
        return running;
      case 'completed':
        return completed;
      case 'aborted':
        return aborted;
      case 'timedOut':
        return timedOut;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "RoutineRecordStatus"');
    }
  }

  @override
  String toJson() => name;
  @override
  String toString() => name;
}
