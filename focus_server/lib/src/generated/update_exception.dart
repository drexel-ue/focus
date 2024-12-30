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

/// To be thrown if there is an exception when updating a row in the database.
abstract class UpdateException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  UpdateException._({required this.message});

  factory UpdateException({required String message}) = _UpdateExceptionImpl;

  factory UpdateException.fromJson(Map<String, dynamic> jsonSerialization) {
    return UpdateException(message: jsonSerialization['message'] as String);
  }

  /// Message to be shown client side.
  String message;

  UpdateException copyWith({String? message});
  @override
  Map<String, dynamic> toJson() {
    return {'message': message};
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {'message': message};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _UpdateExceptionImpl extends UpdateException {
  _UpdateExceptionImpl({required String message}) : super._(message: message);

  @override
  UpdateException copyWith({String? message}) {
    return UpdateException(message: message ?? this.message);
  }
}
