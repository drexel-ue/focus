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
import 'auth_exception.dart' as _i2;
import 'auth_session.dart' as _i3;
import 'auth_token.dart' as _i4;
import 'example.dart' as _i5;
import 'expired_jwt_exception.dart' as _i6;
import 'token_mismatch_exception.dart' as _i7;
import 'user.dart' as _i8;
export 'auth_exception.dart';
export 'auth_session.dart';
export 'auth_token.dart';
export 'example.dart';
export 'expired_jwt_exception.dart';
export 'token_mismatch_exception.dart';
export 'user.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.AuthException) {
      return _i2.AuthException.fromJson(data) as T;
    }
    if (t == _i3.AuthSession) {
      return _i3.AuthSession.fromJson(data) as T;
    }
    if (t == _i4.AuthToken) {
      return _i4.AuthToken.fromJson(data) as T;
    }
    if (t == _i5.Example) {
      return _i5.Example.fromJson(data) as T;
    }
    if (t == _i6.ExpiredJWTException) {
      return _i6.ExpiredJWTException.fromJson(data) as T;
    }
    if (t == _i7.TokenMismatchException) {
      return _i7.TokenMismatchException.fromJson(data) as T;
    }
    if (t == _i8.User) {
      return _i8.User.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AuthException?>()) {
      return (data != null ? _i2.AuthException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AuthSession?>()) {
      return (data != null ? _i3.AuthSession.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AuthToken?>()) {
      return (data != null ? _i4.AuthToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Example?>()) {
      return (data != null ? _i5.Example.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ExpiredJWTException?>()) {
      return (data != null ? _i6.ExpiredJWTException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.TokenMismatchException?>()) {
      return (data != null ? _i7.TokenMismatchException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.User?>()) {
      return (data != null ? _i8.User.fromJson(data) : null) as T;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.AuthException) {
      return 'AuthException';
    }
    if (data is _i3.AuthSession) {
      return 'AuthSession';
    }
    if (data is _i4.AuthToken) {
      return 'AuthToken';
    }
    if (data is _i5.Example) {
      return 'Example';
    }
    if (data is _i6.ExpiredJWTException) {
      return 'ExpiredJWTException';
    }
    if (data is _i7.TokenMismatchException) {
      return 'TokenMismatchException';
    }
    if (data is _i8.User) {
      return 'User';
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
      return deserialize<_i2.AuthException>(data['data']);
    }
    if (dataClassName == 'AuthSession') {
      return deserialize<_i3.AuthSession>(data['data']);
    }
    if (dataClassName == 'AuthToken') {
      return deserialize<_i4.AuthToken>(data['data']);
    }
    if (dataClassName == 'Example') {
      return deserialize<_i5.Example>(data['data']);
    }
    if (dataClassName == 'ExpiredJWTException') {
      return deserialize<_i6.ExpiredJWTException>(data['data']);
    }
    if (dataClassName == 'TokenMismatchException') {
      return deserialize<_i7.TokenMismatchException>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i8.User>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
