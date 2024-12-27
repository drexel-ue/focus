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

/// To be thrown when a token cannot be used to find a [User].
abstract class InvalidTokenException
    implements _i1.SerializableException, _i1.SerializableModel {
  InvalidTokenException._();

  factory InvalidTokenException() = _InvalidTokenExceptionImpl;

  factory InvalidTokenException.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return InvalidTokenException();
  }

  InvalidTokenException copyWith();
  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _InvalidTokenExceptionImpl extends InvalidTokenException {
  _InvalidTokenExceptionImpl() : super._();

  @override
  InvalidTokenException copyWith() {
    return InvalidTokenException();
  }
}
