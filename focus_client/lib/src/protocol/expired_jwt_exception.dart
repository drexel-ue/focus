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

/// To be thrown when server detects an expired jwt.
abstract class ExpiredJWTException
    implements _i1.SerializableException, _i1.SerializableModel {
  ExpiredJWTException._();

  factory ExpiredJWTException() = _ExpiredJWTExceptionImpl;

  factory ExpiredJWTException.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExpiredJWTException();
  }

  ExpiredJWTException copyWith();
  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ExpiredJWTExceptionImpl extends ExpiredJWTException {
  _ExpiredJWTExceptionImpl() : super._();

  @override
  ExpiredJWTException copyWith() {
    return ExpiredJWTException();
  }
}
