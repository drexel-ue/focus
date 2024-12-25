import 'package:focus_client/src/protocol/auth_session.dart';

extension AuthSessionX on AuthSession {
  /// Is this an active [AuthSession]?
  bool get authenticated => token != null && user != null;
}
