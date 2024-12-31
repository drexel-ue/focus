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
import 'dart:async' as _i2;
import 'package:focus_client/src/protocol/auth_session.dart' as _i3;
import 'package:focus_client/src/protocol/auth_token.dart' as _i4;
import 'package:focus_client/src/protocol/routine.dart' as _i5;
import 'package:focus_client/src/protocol/routine_step.dart' as _i6;
import 'package:focus_client/src/protocol/routine_segment.dart' as _i7;
import 'package:focus_client/src/protocol/task.dart' as _i8;
import 'package:focus_client/src/protocol/ability_experience_value.dart' as _i9;
import 'protocol.dart' as _i10;

/// Handles [AuthSession] creation.
/// {@category Endpoint}
class EndpointAuth extends _i1.EndpointRef {
  EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  /// Creates a new [AuthSession].
  _i2.Future<_i3.AuthSession> authenticate() =>
      caller.callServerEndpoint<_i3.AuthSession>(
        'auth',
        'authenticate',
        {},
      );

  /// Exchanges a refresh token for a fresh [AuthSession].
  _i2.Future<_i3.AuthSession> refresh(_i4.AuthToken authToken) =>
      caller.callServerEndpoint<_i3.AuthSession>(
        'auth',
        'refresh',
        {'authToken': authToken},
      );
}

///
/// {@category Endpoint}
class EndpointExample extends _i1.EndpointRef {
  EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  ///
  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

/// Handles work related to [Routine]s.
/// {@category Endpoint}
class EndpointRoutine extends _i1.EndpointRef {
  EndpointRoutine(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'routine';

  /// Get routines for a [User].
  _i2.Future<List<_i5.Routine>> getRoutines(int page) =>
      caller.callServerEndpoint<List<_i5.Routine>>(
        'routine',
        'getRoutines',
        {'page': page},
      );

  /// Creates and returns a new [Routine].
  _i2.Future<_i5.Routine> createRoutine({
    required String title,
    required bool active,
    List<_i6.RoutineStep>? steps,
    List<_i7.RoutineSegment>? segments,
  }) =>
      caller.callServerEndpoint<_i5.Routine>(
        'routine',
        'createRoutine',
        {
          'title': title,
          'active': active,
          'steps': steps,
          'segments': segments,
        },
      );

  /// Updates an existing [Routine].
  _i2.Future<_i5.Routine> updateRoutine({
    required int routineId,
    required String title,
    required bool active,
    List<_i6.RoutineStep>? steps,
    List<_i7.RoutineSegment>? segments,
  }) =>
      caller.callServerEndpoint<_i5.Routine>(
        'routine',
        'updateRoutine',
        {
          'routineId': routineId,
          'title': title,
          'active': active,
          'steps': steps,
          'segments': segments,
        },
      );

  /// Deletes a [Routine].
  _i2.Future<_i5.Routine> deleteRoutine(int routineId) =>
      caller.callServerEndpoint<_i5.Routine>(
        'routine',
        'deleteRoutine',
        {'routineId': routineId},
      );
}

/// Handles work related to [Task]s.
/// {@category Endpoint}
class EndpointTask extends _i1.EndpointRef {
  EndpointTask(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'task';

  /// Get tasks for a [User].
  _i2.Future<List<_i8.Task>> getTasks(int page) =>
      caller.callServerEndpoint<List<_i8.Task>>(
        'task',
        'getTasks',
        {'page': page},
      );

  /// Create a [Task].
  _i2.Future<_i8.Task> createTask({
    required String title,
    String? description,
    required List<_i9.AbilityExperienceValue> abilityExpValues,
  }) =>
      caller.callServerEndpoint<_i8.Task>(
        'task',
        'createTask',
        {
          'title': title,
          'description': description,
          'abilityExpValues': abilityExpValues,
        },
      );

  /// Toggles the completion state of a [Task].
  _i2.Future<_i8.Task> toggleTaskComplete(int taskId) =>
      caller.callServerEndpoint<_i8.Task>(
        'task',
        'toggleTaskComplete',
        {'taskId': taskId},
      );

  /// Update a [Task].
  _i2.Future<_i8.Task> updateTask({
    required int taskId,
    required String title,
    String? description,
    required List<_i9.AbilityExperienceValue> abilityExpValues,
  }) =>
      caller.callServerEndpoint<_i8.Task>(
        'task',
        'updateTask',
        {
          'taskId': taskId,
          'title': title,
          'description': description,
          'abilityExpValues': abilityExpValues,
        },
      );

  /// Deletes a [Task].
  _i2.Future<_i8.Task> deleteTask(int taskId) =>
      caller.callServerEndpoint<_i8.Task>(
        'task',
        'deleteTask',
        {'taskId': taskId},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i10.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    auth = EndpointAuth(this);
    example = EndpointExample(this);
    routine = EndpointRoutine(this);
    task = EndpointTask(this);
  }

  late final EndpointAuth auth;

  late final EndpointExample example;

  late final EndpointRoutine routine;

  late final EndpointTask task;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'auth': auth,
        'example': example,
        'routine': routine,
        'task': task,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
