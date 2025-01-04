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
import 'user.dart' as _i2;
import 'task.dart' as _i3;

/// Wrapper for a [User] and a [Task].
abstract class UserWithTask
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  UserWithTask._({
    required this.user,
    required this.task,
  });

  factory UserWithTask({
    required _i2.User user,
    required _i3.Task task,
  }) = _UserWithTaskImpl;

  factory UserWithTask.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserWithTask(
      user: _i2.User.fromJson(
          (jsonSerialization['user'] as Map<String, dynamic>)),
      task: _i3.Task.fromJson(
          (jsonSerialization['task'] as Map<String, dynamic>)),
    );
  }

  /// [User].
  _i2.User user;

  /// [Task].
  _i3.Task task;

  UserWithTask copyWith({
    _i2.User? user,
    _i3.Task? task,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'task': task.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'user': user.toJsonForProtocol(),
      'task': task.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _UserWithTaskImpl extends UserWithTask {
  _UserWithTaskImpl({
    required _i2.User user,
    required _i3.Task task,
  }) : super._(
          user: user,
          task: task,
        );

  @override
  UserWithTask copyWith({
    _i2.User? user,
    _i3.Task? task,
  }) {
    return UserWithTask(
      user: user ?? this.user.copyWith(),
      task: task ?? this.task.copyWith(),
    );
  }
}
