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

/// To be thrown if there is an exception when querying the database for a specific [Task].
abstract class TaskNotFoundException
    implements _i1.SerializableException, _i1.SerializableModel {
  TaskNotFoundException._({required this.message});

  factory TaskNotFoundException({required String message}) =
      _TaskNotFoundExceptionImpl;

  factory TaskNotFoundException.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return TaskNotFoundException(
        message: jsonSerialization['message'] as String);
  }

  /// Message to be shown client side.
  String message;

  TaskNotFoundException copyWith({String? message});
  @override
  Map<String, dynamic> toJson() {
    return {'message': message};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TaskNotFoundExceptionImpl extends TaskNotFoundException {
  _TaskNotFoundExceptionImpl({required String message})
      : super._(message: message);

  @override
  TaskNotFoundException copyWith({String? message}) {
    return TaskNotFoundException(message: message ?? this.message);
  }
}
