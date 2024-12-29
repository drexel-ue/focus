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
import 'package:focus_client/src/protocol/task.dart' as _i5;
import 'package:focus_client/src/protocol/ability_experience_value.dart' as _i6;
import 'protocol.dart' as _i7;

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

/// Handles work related to [Task]s.
/// {@category Endpoint}
class EndpointTask extends _i1.EndpointRef {
  EndpointTask(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'task';

  /// Get all tasks for a [User].
  _i2.Future<List<_i5.Task>> getTasks(int page) =>
      caller.callServerEndpoint<List<_i5.Task>>(
        'task',
        'getTasks',
        {'page': page},
      );

  /// Create a [Task].
  _i2.Future<_i5.Task> createTask({
    required String title,
    String? description,
    required List<_i6.AbilityExperienceValue> abilityExpValues,
  }) =>
      caller.callServerEndpoint<_i5.Task>(
        'task',
        'createTask',
        {
          'title': title,
          'description': description,
          'abilityExpValues': abilityExpValues,
        },
      );

  /// Toggles the completion state of a [Task].
  _i2.Future<_i5.Task> toggleTaskComplete(int taskId) =>
      caller.callServerEndpoint<_i5.Task>(
        'task',
        'toggleTaskComplete',
        {'taskId': taskId},
      );

  /// Update a [Task].
  _i2.Future<_i5.Task> updateTask({
    required int taskId,
    required String title,
    String? description,
    required List<_i6.AbilityExperienceValue> abilityExpValues,
  }) =>
      caller.callServerEndpoint<_i5.Task>(
        'task',
        'updateTask',
        {
          'taskId': taskId,
          'title': title,
          'description': description,
          'abilityExpValues': abilityExpValues,
        },
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
          _i7.Protocol(),
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
    task = EndpointTask(this);
  }

  late final EndpointAuth auth;

  late final EndpointExample example;

  late final EndpointTask task;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'auth': auth,
        'example': example,
        'task': task,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
