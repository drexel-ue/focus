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
import 'invalid_token_exception.dart' as _i13;
import 'not_found_exception.dart' as _i14;
import 'routine.dart' as _i15;
import 'routine_segment.dart' as _i16;
import 'routine_step.dart' as _i17;
import 'task.dart' as _i18;
import 'token_mismatch_exception.dart' as _i19;
import 'update_exception.dart' as _i20;
import 'user.dart' as _i21;
import 'user_ability_stats.dart' as _i22;
import 'user_buff.dart' as _i23;
import 'user_debuff.dart' as _i24;
import 'package:focus_server/src/generated/routine.dart' as _i25;
import 'package:focus_server/src/generated/routine_step.dart' as _i26;
import 'package:focus_server/src/generated/routine_segment.dart' as _i27;
import 'package:focus_server/src/generated/task.dart' as _i28;
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
export 'invalid_token_exception.dart';
export 'not_found_exception.dart';
export 'routine.dart';
export 'routine_segment.dart';
export 'routine_step.dart';
export 'task.dart';
export 'token_mismatch_exception.dart';
export 'update_exception.dart';
export 'user.dart';
export 'user_ability_stats.dart';
export 'user_buff.dart';
export 'user_debuff.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'routine_segments',
      dartName: 'RoutineSegment',
      schema: 'public',
      module: 'focus',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'routine_segments_id_seq\'::regclass)',
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
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: '_routinesSegmentsRoutinesId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'routine_segments_fk_0',
          columns: ['_routinesSegmentsRoutinesId'],
          referenceTable: 'routines',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'routine_segments_pkey',
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
      name: 'routine_steps',
      dartName: 'RoutineStep',
      schema: 'public',
      module: 'focus',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'routine_steps_id_seq\'::regclass)',
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
          name: 'abilityExpValues',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:AbilityExperienceValue>',
        ),
        _i2.ColumnDefinition(
          name: '_routinesStepsRoutinesId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: '_routineSegmentsStepsRoutineSegmentsId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'routine_steps_fk_0',
          columns: ['_routinesStepsRoutinesId'],
          referenceTable: 'routines',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'routine_steps_fk_1',
          columns: ['_routineSegmentsStepsRoutineSegmentsId'],
          referenceTable: 'routine_segments',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'routine_steps_pkey',
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
          name: 'active',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
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
    if (t == _i13.InvalidTokenException) {
      return _i13.InvalidTokenException.fromJson(data) as T;
    }
    if (t == _i14.NotFoundException) {
      return _i14.NotFoundException.fromJson(data) as T;
    }
    if (t == _i15.Routine) {
      return _i15.Routine.fromJson(data) as T;
    }
    if (t == _i16.RoutineSegment) {
      return _i16.RoutineSegment.fromJson(data) as T;
    }
    if (t == _i17.RoutineStep) {
      return _i17.RoutineStep.fromJson(data) as T;
    }
    if (t == _i18.Task) {
      return _i18.Task.fromJson(data) as T;
    }
    if (t == _i19.TokenMismatchException) {
      return _i19.TokenMismatchException.fromJson(data) as T;
    }
    if (t == _i20.UpdateException) {
      return _i20.UpdateException.fromJson(data) as T;
    }
    if (t == _i21.User) {
      return _i21.User.fromJson(data) as T;
    }
    if (t == _i22.UserAbilityStats) {
      return _i22.UserAbilityStats.fromJson(data) as T;
    }
    if (t == _i23.UserBuff) {
      return _i23.UserBuff.fromJson(data) as T;
    }
    if (t == _i24.UserDebuff) {
      return _i24.UserDebuff.fromJson(data) as T;
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
    if (t == _i1.getType<_i13.InvalidTokenException?>()) {
      return (data != null ? _i13.InvalidTokenException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.NotFoundException?>()) {
      return (data != null ? _i14.NotFoundException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Routine?>()) {
      return (data != null ? _i15.Routine.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.RoutineSegment?>()) {
      return (data != null ? _i16.RoutineSegment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.RoutineStep?>()) {
      return (data != null ? _i17.RoutineStep.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.Task?>()) {
      return (data != null ? _i18.Task.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.TokenMismatchException?>()) {
      return (data != null ? _i19.TokenMismatchException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.UpdateException?>()) {
      return (data != null ? _i20.UpdateException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.User?>()) {
      return (data != null ? _i21.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.UserAbilityStats?>()) {
      return (data != null ? _i22.UserAbilityStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.UserBuff?>()) {
      return (data != null ? _i23.UserBuff.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.UserDebuff?>()) {
      return (data != null ? _i24.UserDebuff.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i17.RoutineStep>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i17.RoutineStep>(e)).toList()
          : null) as dynamic;
    }
    if (t == _i1.getType<List<_i16.RoutineSegment>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.RoutineSegment>(e))
              .toList()
          : null) as dynamic;
    }
    if (t == _i1.getType<List<_i17.RoutineStep>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i17.RoutineStep>(e)).toList()
          : null) as dynamic;
    }
    if (t == List<_i4.AbilityExperienceValue>) {
      return (data as List)
          .map((e) => deserialize<_i4.AbilityExperienceValue>(e))
          .toList() as dynamic;
    }
    if (t == List<_i23.UserBuff>) {
      return (data as List).map((e) => deserialize<_i23.UserBuff>(e)).toList()
          as dynamic;
    }
    if (t == List<_i24.UserDebuff>) {
      return (data as List).map((e) => deserialize<_i24.UserDebuff>(e)).toList()
          as dynamic;
    }
    if (t == List<_i25.Routine>) {
      return (data as List).map((e) => deserialize<_i25.Routine>(e)).toList()
          as dynamic;
    }
    if (t == _i1.getType<List<_i26.RoutineStep>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i26.RoutineStep>(e)).toList()
          : null) as dynamic;
    }
    if (t == _i1.getType<List<_i27.RoutineSegment>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i27.RoutineSegment>(e))
              .toList()
          : null) as dynamic;
    }
    if (t == _i1.getType<List<_i26.RoutineStep>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i26.RoutineStep>(e)).toList()
          : null) as dynamic;
    }
    if (t == _i1.getType<List<_i27.RoutineSegment>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i27.RoutineSegment>(e))
              .toList()
          : null) as dynamic;
    }
    if (t == List<_i28.Task>) {
      return (data as List).map((e) => deserialize<_i28.Task>(e)).toList()
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
    if (data is _i13.InvalidTokenException) {
      return 'InvalidTokenException';
    }
    if (data is _i14.NotFoundException) {
      return 'NotFoundException';
    }
    if (data is _i15.Routine) {
      return 'Routine';
    }
    if (data is _i16.RoutineSegment) {
      return 'RoutineSegment';
    }
    if (data is _i17.RoutineStep) {
      return 'RoutineStep';
    }
    if (data is _i18.Task) {
      return 'Task';
    }
    if (data is _i19.TokenMismatchException) {
      return 'TokenMismatchException';
    }
    if (data is _i20.UpdateException) {
      return 'UpdateException';
    }
    if (data is _i21.User) {
      return 'User';
    }
    if (data is _i22.UserAbilityStats) {
      return 'UserAbilityStats';
    }
    if (data is _i23.UserBuff) {
      return 'UserBuff';
    }
    if (data is _i24.UserDebuff) {
      return 'UserDebuff';
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
    if (dataClassName == 'InvalidTokenException') {
      return deserialize<_i13.InvalidTokenException>(data['data']);
    }
    if (dataClassName == 'NotFoundException') {
      return deserialize<_i14.NotFoundException>(data['data']);
    }
    if (dataClassName == 'Routine') {
      return deserialize<_i15.Routine>(data['data']);
    }
    if (dataClassName == 'RoutineSegment') {
      return deserialize<_i16.RoutineSegment>(data['data']);
    }
    if (dataClassName == 'RoutineStep') {
      return deserialize<_i17.RoutineStep>(data['data']);
    }
    if (dataClassName == 'Task') {
      return deserialize<_i18.Task>(data['data']);
    }
    if (dataClassName == 'TokenMismatchException') {
      return deserialize<_i19.TokenMismatchException>(data['data']);
    }
    if (dataClassName == 'UpdateException') {
      return deserialize<_i20.UpdateException>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i21.User>(data['data']);
    }
    if (dataClassName == 'UserAbilityStats') {
      return deserialize<_i22.UserAbilityStats>(data['data']);
    }
    if (dataClassName == 'UserBuff') {
      return deserialize<_i23.UserBuff>(data['data']);
    }
    if (dataClassName == 'UserDebuff') {
      return deserialize<_i24.UserDebuff>(data['data']);
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
      case _i15.Routine:
        return _i15.Routine.t;
      case _i16.RoutineSegment:
        return _i16.RoutineSegment.t;
      case _i17.RoutineStep:
        return _i17.RoutineStep.t;
      case _i18.Task:
        return _i18.Task.t;
      case _i21.User:
        return _i21.User.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'focus';
}
