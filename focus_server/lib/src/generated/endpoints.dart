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
import '../endpoints/routine_endpoint.dart' as _i4;
import '../endpoints/task_endpoint.dart' as _i5;
import 'package:focus_server/src/generated/auth_token.dart' as _i6;
import 'package:focus_server/src/generated/routine_step.dart' as _i7;
import 'package:focus_server/src/generated/user_buff.dart' as _i8;
import 'package:focus_server/src/generated/user_debuff.dart' as _i9;
import 'package:focus_server/src/generated/user_ability_stats.dart' as _i10;

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
      'routine': _i4.RoutineEndpoint()
        ..initialize(
          server,
          'routine',
          null,
        ),
      'task': _i5.TaskEndpoint()
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
              type: _i1.getType<_i6.AuthToken>(),
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
    connectors['routine'] = _i1.EndpointConnector(
      name: 'routine',
      endpoint: endpoints['routine']!,
      methodConnectors: {
        'getRoutines': _i1.MethodConnector(
          name: 'getRoutines',
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
              (endpoints['routine'] as _i4.RoutineEndpoint).getRoutines(
            session,
            params['page'],
          ),
        ),
        'createRoutine': _i1.MethodConnector(
          name: 'createRoutine',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'steps': _i1.ParameterDescription(
              name: 'steps',
              type: _i1.getType<List<_i7.RoutineStep>>(),
              nullable: false,
            ),
            'buffs': _i1.ParameterDescription(
              name: 'buffs',
              type: _i1.getType<List<_i8.UserBuff>>(),
              nullable: false,
            ),
            'debuffs': _i1.ParameterDescription(
              name: 'debuffs',
              type: _i1.getType<List<_i9.UserDebuff>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['routine'] as _i4.RoutineEndpoint).createRoutine(
            session,
            title: params['title'],
            steps: params['steps'],
            buffs: params['buffs'],
            debuffs: params['debuffs'],
          ),
        ),
        'updateRoutine': _i1.MethodConnector(
          name: 'updateRoutine',
          params: {
            'routineId': _i1.ParameterDescription(
              name: 'routineId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'steps': _i1.ParameterDescription(
              name: 'steps',
              type: _i1.getType<List<_i7.RoutineStep>>(),
              nullable: false,
            ),
            'buffs': _i1.ParameterDescription(
              name: 'buffs',
              type: _i1.getType<List<_i8.UserBuff>>(),
              nullable: false,
            ),
            'debuffs': _i1.ParameterDescription(
              name: 'debuffs',
              type: _i1.getType<List<_i9.UserDebuff>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['routine'] as _i4.RoutineEndpoint).updateRoutine(
            session,
            routineId: params['routineId'],
            title: params['title'],
            steps: params['steps'],
            buffs: params['buffs'],
            debuffs: params['debuffs'],
          ),
        ),
        'deleteRoutine': _i1.MethodConnector(
          name: 'deleteRoutine',
          params: {
            'routineId': _i1.ParameterDescription(
              name: 'routineId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['routine'] as _i4.RoutineEndpoint).deleteRoutine(
            session,
            params['routineId'],
          ),
        ),
        'startRoutine': _i1.MethodConnector(
          name: 'startRoutine',
          params: {
            'routineId': _i1.ParameterDescription(
              name: 'routineId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['routine'] as _i4.RoutineEndpoint).startRoutine(
            session,
            params['routineId'],
          ),
        ),
        'completeRoutine': _i1.MethodConnector(
          name: 'completeRoutine',
          params: {
            'routineId': _i1.ParameterDescription(
              name: 'routineId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['routine'] as _i4.RoutineEndpoint).completeRoutine(
            session,
            params['routineId'],
          ),
        ),
        'abortRoutine': _i1.MethodConnector(
          name: 'abortRoutine',
          params: {
            'routineId': _i1.ParameterDescription(
              name: 'routineId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['routine'] as _i4.RoutineEndpoint).abortRoutine(
            session,
            params['routineId'],
          ),
        ),
        'findRunningRoutine': _i1.MethodConnector(
          name: 'findRunningRoutine',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['routine'] as _i4.RoutineEndpoint)
                  .findRunningRoutine(session),
        ),
        'getRoutineStats': _i1.MethodConnector(
          name: 'getRoutineStats',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['routine'] as _i4.RoutineEndpoint)
                  .getRoutineStats(session),
        ),
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
              (endpoints['task'] as _i5.TaskEndpoint).getTasks(
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
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['task'] as _i5.TaskEndpoint).createTask(
            session,
            title: params['title'],
            description: params['description'],
          ),
        ),
        'completeTask': _i1.MethodConnector(
          name: 'completeTask',
          params: {
            'taskId': _i1.ParameterDescription(
              name: 'taskId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'abilityExpValues': _i1.ParameterDescription(
              name: 'abilityExpValues',
              type: _i1.getType<_i10.UserAbilityStats>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['task'] as _i5.TaskEndpoint).completeTask(
            session,
            params['taskId'],
            params['abilityExpValues'],
          ),
        ),
        'updateTask': _i1.MethodConnector(
          name: 'updateTask',
          params: {
            'taskId': _i1.ParameterDescription(
              name: 'taskId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['task'] as _i5.TaskEndpoint).updateTask(
            session,
            taskId: params['taskId'],
            title: params['title'],
            description: params['description'],
          ),
        ),
        'deleteTask': _i1.MethodConnector(
          name: 'deleteTask',
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
              (endpoints['task'] as _i5.TaskEndpoint).deleteTask(
            session,
            params['taskId'],
          ),
        ),
        'getTaskStats': _i1.MethodConnector(
          name: 'getTaskStats',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['task'] as _i5.TaskEndpoint).getTaskStats(session),
        ),
      },
    );
  }
}
