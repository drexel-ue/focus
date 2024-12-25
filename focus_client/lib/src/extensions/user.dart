import 'package:focus_client/src/protocol/user.dart';

extension UserX on User {
  String get fullName {
    if ((firstName?.isNotEmpty ?? false) && (lastName?.isNotEmpty ?? false)) {
      return '$firstName $lastName';
    }
    if ((firstName?.isNotEmpty ?? false) && (lastName?.isEmpty ?? true)) {
      return '$firstName';
    }
    if ((lastName?.isNotEmpty ?? false) && (firstName?.isEmpty ?? true)) {
      return '$lastName';
    }
    return '';
  }
}
