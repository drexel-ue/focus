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
import '../endpoints/auth_endpoint.dart' as _i2;
import '../endpoints/example_endpoint.dart' as _i3;
import '../endpoints/task_endpoint.dart' as _i4;
import 'package:focus_server/src/generated/auth_token.dart' as _i5;
import 'package:focus_server/src/generated/ability_experience_value.dart'
    as _i6;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'auth': _i2.AuthEndpoint()
        ..initialize(
          server,
          'auth',
          null,
        ),
      'example': _i3.ExampleEndpoint()
        ..initialize(
          server,
          'example',
          null,
        ),
      'task': _i4.TaskEndpoint()
        ..initialize(
          server,
          'task',
          null,
        ),
    };
    connectors['auth'] = _i1.EndpointConnector(
      name: 'auth',
      endpoint: endpoints['auth']!,
      methodConnectors: {
        'authenticate': _i1.MethodConnector(
          name: 'authenticate',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).authenticate(session),
        ),
        'refresh': _i1.MethodConnector(
          name: 'refresh',
          params: {
            'authToken': _i1.ParameterDescription(
              name: 'authToken',
              type: _i1.getType<_i5.AuthToken>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).refresh(
            session,
            params['authToken'],
          ),
        ),
      },
    );
    connectors['example'] = _i1.EndpointConnector(
      name: 'example',
      endpoint: endpoints['example']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['example'] as _i3.ExampleEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    connectors['task'] = _i1.EndpointConnector(
      name: 'task',
      endpoint: endpoints['task']!,
      methodConnectors: {
        'getTasks': _i1.MethodConnector(
          name: 'getTasks',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['task'] as _i4.TaskEndpoint).getTasks(
            session,
            params['page'],
          ),
        ),
        'createTask': _i1.MethodConnector(
          name: 'createTask',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'desription': _i1.ParameterDescription(
              name: 'desription',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'abilityExpValues': _i1.ParameterDescription(
              name: 'abilityExpValues',
              type: _i1.getType<List<_i6.AbilityExperienceValue>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['task'] as _i4.TaskEndpoint).createTask(
            session,
            title: params['title'],
            desription: params['desription'],
            abilityExpValues: params['abilityExpValues'],
          ),
        ),
        'toggleTaskComplete': _i1.MethodConnector(
          name: 'toggleTaskComplete',
          params: {
            'taskId': _i1.ParameterDescription(
              name: 'taskId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['task'] as _i4.TaskEndpoint).toggleTaskComplete(
            session,
            params['taskId'],
          ),
        ),
      },
    );
  }
}
