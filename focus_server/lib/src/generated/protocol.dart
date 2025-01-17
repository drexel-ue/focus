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
import 'package:serverpod/protocol.dart' as _i2;
import 'ability.dart' as _i3;
import 'ability_experience_value.dart' as _i4;
import 'auth_exception.dart' as _i5;
import 'auth_session.dart' as _i6;
import 'auth_token.dart' as _i7;
import 'creation_exception.dart' as _i8;
import 'deletion_exception.dart' as _i9;
import 'example.dart' as _i10;
import 'expired_jwt_exception.dart' as _i11;
import 'fetch_exception.dart' as _i12;
import 'future_call_exception.dart' as _i13;
import 'invalid_token_exception.dart' as _i14;
import 'not_found_exception.dart' as _i15;
import 'routine.dart' as _i16;
import 'routine_record.dart' as _i17;
import 'routine_record_status.dart' as _i18;
import 'routine_step.dart' as _i19;
import 'routine_step_type.dart' as _i20;
import 'routine_with_record.dart' as _i21;
import 'task.dart' as _i22;
import 'task_stats.dart' as _i23;
import 'token_mismatch_exception.dart' as _i24;
import 'update_exception.dart' as _i25;
import 'user.dart' as _i26;
import 'user_ability_stats.dart' as _i27;
import 'user_buff.dart' as _i28;
import 'user_debuff.dart' as _i29;
import 'user_with_routine_record.dart' as _i30;
import 'user_with_task.dart' as _i31;
import 'package:focus_server/src/generated/routine.dart' as _i32;
import 'package:focus_server/src/generated/routine_step.dart' as _i33;
import 'package:focus_server/src/generated/user_buff.dart' as _i34;
import 'package:focus_server/src/generated/user_debuff.dart' as _i35;
import 'package:focus_server/src/generated/task.dart' as _i36;
export 'ability.dart';
export 'ability_experience_value.dart';
export 'auth_exception.dart';
export 'auth_session.dart';
export 'auth_token.dart';
export 'creation_exception.dart';
export 'deletion_exception.dart';
export 'example.dart';
export 'expired_jwt_exception.dart';
export 'fetch_exception.dart';
export 'future_call_exception.dart';
export 'invalid_token_exception.dart';
export 'not_found_exception.dart';
export 'routine.dart';
export 'routine_record.dart';
export 'routine_record_status.dart';
export 'routine_step.dart';
export 'routine_step_type.dart';
export 'routine_with_record.dart';
export 'task.dart';
export 'task_stats.dart';
export 'token_mismatch_exception.dart';
export 'update_exception.dart';
export 'user.dart';
export 'user_ability_stats.dart';
export 'user_buff.dart';
export 'user_debuff.dart';
export 'user_with_routine_record.dart';
export 'user_with_task.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'routine_records',
      dartName: 'RoutineRecord',
      schema: 'public',
      module: 'focus',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'routine_records_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'lastModifiedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'routineId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RoutineRecordStatus',
          columnDefault: '\'running\'::text',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'routine_records_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'routines',
      dartName: 'Routine',
      schema: 'public',
      module: 'focus',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'routines_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'lastModifiedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'steps',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:RoutineStep>',
        ),
        _i2.ColumnDefinition(
          name: 'buffs',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:UserBuff>',
        ),
        _i2.ColumnDefinition(
          name: 'debuffs',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:UserDebuff>',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'routines_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'tasks',
      dartName: 'Task',
      schema: 'public',
      module: 'focus',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'tasks_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'lastModifiedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'completed',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'abilityExpValues',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:UserAbilityStats',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'tasks_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'users',
      dartName: 'User',
      schema: 'public',
      module: 'focus',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'users_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'lastModifiedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'clerkUserId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'firstName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'lastName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'profileImageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'abilityStats',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:UserAbilityStats',
        ),
        _i2.ColumnDefinition(
          name: 'buffs',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:UserBuff>',
        ),
        _i2.ColumnDefinition(
          name: 'debuffs',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:UserDebuff>',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'users_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    ..._i2.Protocol.targetTableDefinitions,
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i3.Ability) {
      return _i3.Ability.fromJson(data) as T;
    }
    if (t == _i4.AbilityExperienceValue) {
      return _i4.AbilityExperienceValue.fromJson(data) as T;
    }
    if (t == _i5.AuthException) {
      return _i5.AuthException.fromJson(data) as T;
    }
    if (t == _i6.AuthSession) {
      return _i6.AuthSession.fromJson(data) as T;
    }
    if (t == _i7.AuthToken) {
      return _i7.AuthToken.fromJson(data) as T;
    }
    if (t == _i8.CreationException) {
      return _i8.CreationException.fromJson(data) as T;
    }
    if (t == _i9.DeletionException) {
      return _i9.DeletionException.fromJson(data) as T;
    }
    if (t == _i10.Example) {
      return _i10.Example.fromJson(data) as T;
    }
    if (t == _i11.ExpiredJWTException) {
      return _i11.ExpiredJWTException.fromJson(data) as T;
    }
    if (t == _i12.FetchException) {
      return _i12.FetchException.fromJson(data) as T;
    }
    if (t == _i13.FutureCallException) {
      return _i13.FutureCallException.fromJson(data) as T;
    }
    if (t == _i14.InvalidTokenException) {
      return _i14.InvalidTokenException.fromJson(data) as T;
    }
    if (t == _i15.NotFoundException) {
      return _i15.NotFoundException.fromJson(data) as T;
    }
    if (t == _i16.Routine) {
      return _i16.Routine.fromJson(data) as T;
    }
    if (t == _i17.RoutineRecord) {
      return _i17.RoutineRecord.fromJson(data) as T;
    }
    if (t == _i18.RoutineRecordStatus) {
      return _i18.RoutineRecordStatus.fromJson(data) as T;
    }
    if (t == _i19.RoutineStep) {
      return _i19.RoutineStep.fromJson(data) as T;
    }
    if (t == _i20.RoutineStepType) {
      return _i20.RoutineStepType.fromJson(data) as T;
    }
    if (t == _i21.RoutineWithRecord) {
      return _i21.RoutineWithRecord.fromJson(data) as T;
    }
    if (t == _i22.Task) {
      return _i22.Task.fromJson(data) as T;
    }
    if (t == _i23.TaskStats) {
      return _i23.TaskStats.fromJson(data) as T;
    }
    if (t == _i24.TokenMismatchException) {
      return _i24.TokenMismatchException.fromJson(data) as T;
    }
    if (t == _i25.UpdateException) {
      return _i25.UpdateException.fromJson(data) as T;
    }
    if (t == _i26.User) {
      return _i26.User.fromJson(data) as T;
    }
    if (t == _i27.UserAbilityStats) {
      return _i27.UserAbilityStats.fromJson(data) as T;
    }
    if (t == _i28.UserBuff) {
      return _i28.UserBuff.fromJson(data) as T;
    }
    if (t == _i29.UserDebuff) {
      return _i29.UserDebuff.fromJson(data) as T;
    }
    if (t == _i30.UserWithRoutineRecord) {
      return _i30.UserWithRoutineRecord.fromJson(data) as T;
    }
    if (t == _i31.UserWithTask) {
      return _i31.UserWithTask.fromJson(data) as T;
    }
    if (t == _i1.getType<_i3.Ability?>()) {
      return (data != null ? _i3.Ability.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AbilityExperienceValue?>()) {
      return (data != null ? _i4.AbilityExperienceValue.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i5.AuthException?>()) {
      return (data != null ? _i5.AuthException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AuthSession?>()) {
      return (data != null ? _i6.AuthSession.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AuthToken?>()) {
      return (data != null ? _i7.AuthToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.CreationException?>()) {
      return (data != null ? _i8.CreationException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.DeletionException?>()) {
      return (data != null ? _i9.DeletionException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Example?>()) {
      return (data != null ? _i10.Example.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.ExpiredJWTException?>()) {
      return (data != null ? _i11.ExpiredJWTException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.FetchException?>()) {
      return (data != null ? _i12.FetchException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.FutureCallException?>()) {
      return (data != null ? _i13.FutureCallException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.InvalidTokenException?>()) {
      return (data != null ? _i14.InvalidTokenException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.NotFoundException?>()) {
      return (data != null ? _i15.NotFoundException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.Routine?>()) {
      return (data != null ? _i16.Routine.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.RoutineRecord?>()) {
      return (data != null ? _i17.RoutineRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.RoutineRecordStatus?>()) {
      return (data != null ? _i18.RoutineRecordStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.RoutineStep?>()) {
      return (data != null ? _i19.RoutineStep.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.RoutineStepType?>()) {
      return (data != null ? _i20.RoutineStepType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.RoutineWithRecord?>()) {
      return (data != null ? _i21.RoutineWithRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.Task?>()) {
      return (data != null ? _i22.Task.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.TaskStats?>()) {
      return (data != null ? _i23.TaskStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.TokenMismatchException?>()) {
      return (data != null ? _i24.TokenMismatchException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.UpdateException?>()) {
      return (data != null ? _i25.UpdateException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.User?>()) {
      return (data != null ? _i26.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.UserAbilityStats?>()) {
      return (data != null ? _i27.UserAbilityStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.UserBuff?>()) {
      return (data != null ? _i28.UserBuff.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.UserDebuff?>()) {
      return (data != null ? _i29.UserDebuff.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.UserWithRoutineRecord?>()) {
      return (data != null ? _i30.UserWithRoutineRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.UserWithTask?>()) {
      return (data != null ? _i31.UserWithTask.fromJson(data) : null) as T;
    }
    if (t == List<_i19.RoutineStep>) {
      return (data as List)
          .map((e) => deserialize<_i19.RoutineStep>(e))
          .toList() as dynamic;
    }
    if (t == List<_i28.UserBuff>) {
      return (data as List).map((e) => deserialize<_i28.UserBuff>(e)).toList()
          as dynamic;
    }
    if (t == List<_i29.UserDebuff>) {
      return (data as List).map((e) => deserialize<_i29.UserDebuff>(e)).toList()
          as dynamic;
    }
    if (t == List<_i32.Routine>) {
      return (data as List).map((e) => deserialize<_i32.Routine>(e)).toList()
          as dynamic;
    }
    if (t == List<_i33.RoutineStep>) {
      return (data as List)
          .map((e) => deserialize<_i33.RoutineStep>(e))
          .toList() as dynamic;
    }
    if (t == List<_i34.UserBuff>) {
      return (data as List).map((e) => deserialize<_i34.UserBuff>(e)).toList()
          as dynamic;
    }
    if (t == List<_i35.UserDebuff>) {
      return (data as List).map((e) => deserialize<_i35.UserDebuff>(e)).toList()
          as dynamic;
    }
    if (t == List<_i36.Task>) {
      return (data as List).map((e) => deserialize<_i36.Task>(e)).toList()
          as dynamic;
    }
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i3.Ability) {
      return 'Ability';
    }
    if (data is _i4.AbilityExperienceValue) {
      return 'AbilityExperienceValue';
    }
    if (data is _i5.AuthException) {
      return 'AuthException';
    }
    if (data is _i6.AuthSession) {
      return 'AuthSession';
    }
    if (data is _i7.AuthToken) {
      return 'AuthToken';
    }
    if (data is _i8.CreationException) {
      return 'CreationException';
    }
    if (data is _i9.DeletionException) {
      return 'DeletionException';
    }
    if (data is _i10.Example) {
      return 'Example';
    }
    if (data is _i11.ExpiredJWTException) {
      return 'ExpiredJWTException';
    }
    if (data is _i12.FetchException) {
      return 'FetchException';
    }
    if (data is _i13.FutureCallException) {
      return 'FutureCallException';
    }
    if (data is _i14.InvalidTokenException) {
      return 'InvalidTokenException';
    }
    if (data is _i15.NotFoundException) {
      return 'NotFoundException';
    }
    if (data is _i16.Routine) {
      return 'Routine';
    }
    if (data is _i17.RoutineRecord) {
      return 'RoutineRecord';
    }
    if (data is _i18.RoutineRecordStatus) {
      return 'RoutineRecordStatus';
    }
    if (data is _i19.RoutineStep) {
      return 'RoutineStep';
    }
    if (data is _i20.RoutineStepType) {
      return 'RoutineStepType';
    }
    if (data is _i21.RoutineWithRecord) {
      return 'RoutineWithRecord';
    }
    if (data is _i22.Task) {
      return 'Task';
    }
    if (data is _i23.TaskStats) {
      return 'TaskStats';
    }
    if (data is _i24.TokenMismatchException) {
      return 'TokenMismatchException';
    }
    if (data is _i25.UpdateException) {
      return 'UpdateException';
    }
    if (data is _i26.User) {
      return 'User';
    }
    if (data is _i27.UserAbilityStats) {
      return 'UserAbilityStats';
    }
    if (data is _i28.UserBuff) {
      return 'UserBuff';
    }
    if (data is _i29.UserDebuff) {
      return 'UserDebuff';
    }
    if (data is _i30.UserWithRoutineRecord) {
      return 'UserWithRoutineRecord';
    }
    if (data is _i31.UserWithTask) {
      return 'UserWithTask';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Ability') {
      return deserialize<_i3.Ability>(data['data']);
    }
    if (dataClassName == 'AbilityExperienceValue') {
      return deserialize<_i4.AbilityExperienceValue>(data['data']);
    }
    if (dataClassName == 'AuthException') {
      return deserialize<_i5.AuthException>(data['data']);
    }
    if (dataClassName == 'AuthSession') {
      return deserialize<_i6.AuthSession>(data['data']);
    }
    if (dataClassName == 'AuthToken') {
      return deserialize<_i7.AuthToken>(data['data']);
    }
    if (dataClassName == 'CreationException') {
      return deserialize<_i8.CreationException>(data['data']);
    }
    if (dataClassName == 'DeletionException') {
      return deserialize<_i9.DeletionException>(data['data']);
    }
    if (dataClassName == 'Example') {
      return deserialize<_i10.Example>(data['data']);
    }
    if (dataClassName == 'ExpiredJWTException') {
      return deserialize<_i11.ExpiredJWTException>(data['data']);
    }
    if (dataClassName == 'FetchException') {
      return deserialize<_i12.FetchException>(data['data']);
    }
    if (dataClassName == 'FutureCallException') {
      return deserialize<_i13.FutureCallException>(data['data']);
    }
    if (dataClassName == 'InvalidTokenException') {
      return deserialize<_i14.InvalidTokenException>(data['data']);
    }
    if (dataClassName == 'NotFoundException') {
      return deserialize<_i15.NotFoundException>(data['data']);
    }
    if (dataClassName == 'Routine') {
      return deserialize<_i16.Routine>(data['data']);
    }
    if (dataClassName == 'RoutineRecord') {
      return deserialize<_i17.RoutineRecord>(data['data']);
    }
    if (dataClassName == 'RoutineRecordStatus') {
      return deserialize<_i18.RoutineRecordStatus>(data['data']);
    }
    if (dataClassName == 'RoutineStep') {
      return deserialize<_i19.RoutineStep>(data['data']);
    }
    if (dataClassName == 'RoutineStepType') {
      return deserialize<_i20.RoutineStepType>(data['data']);
    }
    if (dataClassName == 'RoutineWithRecord') {
      return deserialize<_i21.RoutineWithRecord>(data['data']);
    }
    if (dataClassName == 'Task') {
      return deserialize<_i22.Task>(data['data']);
    }
    if (dataClassName == 'TaskStats') {
      return deserialize<_i23.TaskStats>(data['data']);
    }
    if (dataClassName == 'TokenMismatchException') {
      return deserialize<_i24.TokenMismatchException>(data['data']);
    }
    if (dataClassName == 'UpdateException') {
      return deserialize<_i25.UpdateException>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i26.User>(data['data']);
    }
    if (dataClassName == 'UserAbilityStats') {
      return deserialize<_i27.UserAbilityStats>(data['data']);
    }
    if (dataClassName == 'UserBuff') {
      return deserialize<_i28.UserBuff>(data['data']);
    }
    if (dataClassName == 'UserDebuff') {
      return deserialize<_i29.UserDebuff>(data['data']);
    }
    if (dataClassName == 'UserWithRoutineRecord') {
      return deserialize<_i30.UserWithRoutineRecord>(data['data']);
    }
    if (dataClassName == 'UserWithTask') {
      return deserialize<_i31.UserWithTask>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i16.Routine:
        return _i16.Routine.t;
      case _i17.RoutineRecord:
        return _i17.RoutineRecord.t;
      case _i22.Task:
        return _i22.Task.t;
      case _i26.User:
        return _i26.User.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'focus';
}
