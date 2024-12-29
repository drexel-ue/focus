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
import 'ability.dart' as _i2;
import 'ability_experience_value.dart' as _i3;
import 'auth_exception.dart' as _i4;
import 'auth_session.dart' as _i5;
import 'auth_token.dart' as _i6;
import 'example.dart' as _i7;
import 'expired_jwt_exception.dart' as _i8;
import 'invalid_token_exception.dart' as _i9;
import 'task.dart' as _i10;
import 'task_creation_exception.dart' as _i11;
import 'task_deletion_exception.dart' as _i12;
import 'task_exception.dart' as _i13;
import 'task_fetch_exception.dart' as _i14;
import 'task_not_found_exception.dart' as _i15;
import 'task_update_exception.dart' as _i16;
import 'token_mismatch_exception.dart' as _i17;
import 'user.dart' as _i18;
import 'package:focus_client/src/protocol/task.dart' as _i19;
import 'package:focus_client/src/protocol/ability_experience_value.dart'
    as _i20;
export 'ability.dart';
export 'ability_experience_value.dart';
export 'auth_exception.dart';
export 'auth_session.dart';
export 'auth_token.dart';
export 'example.dart';
export 'expired_jwt_exception.dart';
export 'invalid_token_exception.dart';
export 'task.dart';
export 'task_creation_exception.dart';
export 'task_deletion_exception.dart';
export 'task_exception.dart';
export 'task_fetch_exception.dart';
export 'task_not_found_exception.dart';
export 'task_update_exception.dart';
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
    if (t == _i2.Ability) {
      return _i2.Ability.fromJson(data) as T;
    }
    if (t == _i3.AbilityExperienceValue) {
      return _i3.AbilityExperienceValue.fromJson(data) as T;
    }
    if (t == _i4.AuthException) {
      return _i4.AuthException.fromJson(data) as T;
    }
    if (t == _i5.AuthSession) {
      return _i5.AuthSession.fromJson(data) as T;
    }
    if (t == _i6.AuthToken) {
      return _i6.AuthToken.fromJson(data) as T;
    }
    if (t == _i7.Example) {
      return _i7.Example.fromJson(data) as T;
    }
    if (t == _i8.ExpiredJWTException) {
      return _i8.ExpiredJWTException.fromJson(data) as T;
    }
    if (t == _i9.InvalidTokenException) {
      return _i9.InvalidTokenException.fromJson(data) as T;
    }
    if (t == _i10.Task) {
      return _i10.Task.fromJson(data) as T;
    }
    if (t == _i11.TaskCreationException) {
      return _i11.TaskCreationException.fromJson(data) as T;
    }
    if (t == _i12.TaskDeletionException) {
      return _i12.TaskDeletionException.fromJson(data) as T;
    }
    if (t == _i13.TaskException) {
      return _i13.TaskException.fromJson(data) as T;
    }
    if (t == _i14.TaskFetchException) {
      return _i14.TaskFetchException.fromJson(data) as T;
    }
    if (t == _i15.TaskNotFoundException) {
      return _i15.TaskNotFoundException.fromJson(data) as T;
    }
    if (t == _i16.TaskUpdateException) {
      return _i16.TaskUpdateException.fromJson(data) as T;
    }
    if (t == _i17.TokenMismatchException) {
      return _i17.TokenMismatchException.fromJson(data) as T;
    }
    if (t == _i18.User) {
      return _i18.User.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Ability?>()) {
      return (data != null ? _i2.Ability.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AbilityExperienceValue?>()) {
      return (data != null ? _i3.AbilityExperienceValue.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i4.AuthException?>()) {
      return (data != null ? _i4.AuthException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AuthSession?>()) {
      return (data != null ? _i5.AuthSession.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AuthToken?>()) {
      return (data != null ? _i6.AuthToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Example?>()) {
      return (data != null ? _i7.Example.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.ExpiredJWTException?>()) {
      return (data != null ? _i8.ExpiredJWTException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.InvalidTokenException?>()) {
      return (data != null ? _i9.InvalidTokenException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.Task?>()) {
      return (data != null ? _i10.Task.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.TaskCreationException?>()) {
      return (data != null ? _i11.TaskCreationException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.TaskDeletionException?>()) {
      return (data != null ? _i12.TaskDeletionException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.TaskException?>()) {
      return (data != null ? _i13.TaskException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.TaskFetchException?>()) {
      return (data != null ? _i14.TaskFetchException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.TaskNotFoundException?>()) {
      return (data != null ? _i15.TaskNotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.TaskUpdateException?>()) {
      return (data != null ? _i16.TaskUpdateException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.TokenMismatchException?>()) {
      return (data != null ? _i17.TokenMismatchException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.User?>()) {
      return (data != null ? _i18.User.fromJson(data) : null) as T;
    }
    if (t == List<_i3.AbilityExperienceValue>) {
      return (data as List)
          .map((e) => deserialize<_i3.AbilityExperienceValue>(e))
          .toList() as dynamic;
    }
    if (t == List<_i19.Task>) {
      return (data as List).map((e) => deserialize<_i19.Task>(e)).toList()
          as dynamic;
    }
    if (t == List<_i20.AbilityExperienceValue>) {
      return (data as List)
          .map((e) => deserialize<_i20.AbilityExperienceValue>(e))
          .toList() as dynamic;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.Ability) {
      return 'Ability';
    }
    if (data is _i3.AbilityExperienceValue) {
      return 'AbilityExperienceValue';
    }
    if (data is _i4.AuthException) {
      return 'AuthException';
    }
    if (data is _i5.AuthSession) {
      return 'AuthSession';
    }
    if (data is _i6.AuthToken) {
      return 'AuthToken';
    }
    if (data is _i7.Example) {
      return 'Example';
    }
    if (data is _i8.ExpiredJWTException) {
      return 'ExpiredJWTException';
    }
    if (data is _i9.InvalidTokenException) {
      return 'InvalidTokenException';
    }
    if (data is _i10.Task) {
      return 'Task';
    }
    if (data is _i11.TaskCreationException) {
      return 'TaskCreationException';
    }
    if (data is _i12.TaskDeletionException) {
      return 'TaskDeletionException';
    }
    if (data is _i13.TaskException) {
      return 'TaskException';
    }
    if (data is _i14.TaskFetchException) {
      return 'TaskFetchException';
    }
    if (data is _i15.TaskNotFoundException) {
      return 'TaskNotFoundException';
    }
    if (data is _i16.TaskUpdateException) {
      return 'TaskUpdateException';
    }
    if (data is _i17.TokenMismatchException) {
      return 'TokenMismatchException';
    }
    if (data is _i18.User) {
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
    if (dataClassName == 'Ability') {
      return deserialize<_i2.Ability>(data['data']);
    }
    if (dataClassName == 'AbilityExperienceValue') {
      return deserialize<_i3.AbilityExperienceValue>(data['data']);
    }
    if (dataClassName == 'AuthException') {
      return deserialize<_i4.AuthException>(data['data']);
    }
    if (dataClassName == 'AuthSession') {
      return deserialize<_i5.AuthSession>(data['data']);
    }
    if (dataClassName == 'AuthToken') {
      return deserialize<_i6.AuthToken>(data['data']);
    }
    if (dataClassName == 'Example') {
      return deserialize<_i7.Example>(data['data']);
    }
    if (dataClassName == 'ExpiredJWTException') {
      return deserialize<_i8.ExpiredJWTException>(data['data']);
    }
    if (dataClassName == 'InvalidTokenException') {
      return deserialize<_i9.InvalidTokenException>(data['data']);
    }
    if (dataClassName == 'Task') {
      return deserialize<_i10.Task>(data['data']);
    }
    if (dataClassName == 'TaskCreationException') {
      return deserialize<_i11.TaskCreationException>(data['data']);
    }
    if (dataClassName == 'TaskDeletionException') {
      return deserialize<_i12.TaskDeletionException>(data['data']);
    }
    if (dataClassName == 'TaskException') {
      return deserialize<_i13.TaskException>(data['data']);
    }
    if (dataClassName == 'TaskFetchException') {
      return deserialize<_i14.TaskFetchException>(data['data']);
    }
    if (dataClassName == 'TaskNotFoundException') {
      return deserialize<_i15.TaskNotFoundException>(data['data']);
    }
    if (dataClassName == 'TaskUpdateException') {
      return deserialize<_i16.TaskUpdateException>(data['data']);
    }
    if (dataClassName == 'TokenMismatchException') {
      return deserialize<_i17.TokenMismatchException>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i18.User>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
