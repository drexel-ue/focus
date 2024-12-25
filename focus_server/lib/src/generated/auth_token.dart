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

/// Contains an access and refresh token.
abstract class AuthToken
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AuthToken._({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthToken({
    required String accessToken,
    required String refreshToken,
  }) = _AuthTokenImpl;

  factory AuthToken.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuthToken(
      accessToken: jsonSerialization['accessToken'] as String,
      refreshToken: jsonSerialization['refreshToken'] as String,
    );
  }

  /// Access token.
  String accessToken;

  /// Refresh token keyed to access token.
  String refreshToken;

  AuthToken copyWith({
    String? accessToken,
    String? refreshToken,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AuthTokenImpl extends AuthToken {
  _AuthTokenImpl({
    required String accessToken,
    required String refreshToken,
  }) : super._(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

  @override
  AuthToken copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return AuthToken(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
