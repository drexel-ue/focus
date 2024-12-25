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
import 'auth_token.dart' as _i2;
import 'user.dart' as _i3;

/// Auth session containing an [AuthToken] and a [User].
abstract class AuthSession
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AuthSession._({
    this.token,
    this.user,
  });

  factory AuthSession({
    _i2.AuthToken? token,
    _i3.User? user,
  }) = _AuthSessionImpl;

  factory AuthSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuthSession(
      token: jsonSerialization['token'] == null
          ? null
          : _i2.AuthToken.fromJson(
              (jsonSerialization['token'] as Map<String, dynamic>)),
      user: jsonSerialization['user'] == null
          ? null
          : _i3.User.fromJson(
              (jsonSerialization['user'] as Map<String, dynamic>)),
    );
  }

  /// [AuthToken].
  _i2.AuthToken? token;

  /// [User].
  _i3.User? user;

  AuthSession copyWith({
    _i2.AuthToken? token,
    _i3.User? user,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (token != null) 'token': token?.toJson(),
      if (user != null) 'user': user?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (token != null) 'token': token?.toJsonForProtocol(),
      if (user != null) 'user': user?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuthSessionImpl extends AuthSession {
  _AuthSessionImpl({
    _i2.AuthToken? token,
    _i3.User? user,
  }) : super._(
          token: token,
          user: user,
        );

  @override
  AuthSession copyWith({
    Object? token = _Undefined,
    Object? user = _Undefined,
  }) {
    return AuthSession(
      token: token is _i2.AuthToken? ? token : this.token?.copyWith(),
      user: user is _i3.User? ? user : this.user?.copyWith(),
    );
  }
}
