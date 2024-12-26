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
import 'auth_exception.dart' as _i3;
import 'auth_session.dart' as _i4;
import 'auth_token.dart' as _i5;
import 'example.dart' as _i6;
import 'expired_jwt_exception.dart' as _i7;
import 'token_mismatch_exception.dart' as _i8;
import 'user.dart' as _i9;
export 'auth_exception.dart';
export 'auth_session.dart';
export 'auth_token.dart';
export 'example.dart';
export 'expired_jwt_exception.dart';
export 'token_mismatch_exception.dart';
export 'user.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
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
    if (t == _i3.AuthException) {
      return _i3.AuthException.fromJson(data) as T;
    }
    if (t == _i4.AuthSession) {
      return _i4.AuthSession.fromJson(data) as T;
    }
    if (t == _i5.AuthToken) {
      return _i5.AuthToken.fromJson(data) as T;
    }
    if (t == _i6.Example) {
      return _i6.Example.fromJson(data) as T;
    }
    if (t == _i7.ExpiredJWTException) {
      return _i7.ExpiredJWTException.fromJson(data) as T;
    }
    if (t == _i8.TokenMismatchException) {
      return _i8.TokenMismatchException.fromJson(data) as T;
    }
    if (t == _i9.User) {
      return _i9.User.fromJson(data) as T;
    }
    if (t == _i1.getType<_i3.AuthException?>()) {
      return (data != null ? _i3.AuthException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AuthSession?>()) {
      return (data != null ? _i4.AuthSession.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AuthToken?>()) {
      return (data != null ? _i5.AuthToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Example?>()) {
      return (data != null ? _i6.Example.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.ExpiredJWTException?>()) {
      return (data != null ? _i7.ExpiredJWTException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.TokenMismatchException?>()) {
      return (data != null ? _i8.TokenMismatchException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.User?>()) {
      return (data != null ? _i9.User.fromJson(data) : null) as T;
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
    if (data is _i3.AuthException) {
      return 'AuthException';
    }
    if (data is _i4.AuthSession) {
      return 'AuthSession';
    }
    if (data is _i5.AuthToken) {
      return 'AuthToken';
    }
    if (data is _i6.Example) {
      return 'Example';
    }
    if (data is _i7.ExpiredJWTException) {
      return 'ExpiredJWTException';
    }
    if (data is _i8.TokenMismatchException) {
      return 'TokenMismatchException';
    }
    if (data is _i9.User) {
      return 'User';
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
    if (dataClassName == 'AuthException') {
      return deserialize<_i3.AuthException>(data['data']);
    }
    if (dataClassName == 'AuthSession') {
      return deserialize<_i4.AuthSession>(data['data']);
    }
    if (dataClassName == 'AuthToken') {
      return deserialize<_i5.AuthToken>(data['data']);
    }
    if (dataClassName == 'Example') {
      return deserialize<_i6.Example>(data['data']);
    }
    if (dataClassName == 'ExpiredJWTException') {
      return deserialize<_i7.ExpiredJWTException>(data['data']);
    }
    if (dataClassName == 'TokenMismatchException') {
      return deserialize<_i8.TokenMismatchException>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i9.User>(data['data']);
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
      case _i9.User:
        return _i9.User.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'focus';
}
