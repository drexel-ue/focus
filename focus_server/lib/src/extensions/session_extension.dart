import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:focus_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

///
extension SessionX on Session {
  /// Parses [User] from clerk auth token.
  Future<User> parseUserFromClerkSession() async {
    final clerkPem = await File(passwords['clerkJwtPem'] as String).readAsString();
    final key = RSAPublicKey(clerkPem);
    final jwt = JWT.verify(authenticationKey!, key);
    return User(
      clerkUserId: jwt.payload['clerk_id'],
      firstName: jwt.payload['first_name'],
      lastName: jwt.payload['last_name'],
      profileImageUrl: jwt.payload['image_url'],
    );
  }

  /// Parses [User] from focus auth token.
  Future<User> parseUserFromFocusSession([Transaction? transaction]) async {
    // FIXME(drexel-ue): replace with actual key.
    final jwt = JWT.verify(authenticationKey!, SecretKey('secret'));
    final user = await User.db.findById(this, int.parse(jwt.subject!), transaction: transaction);
    if (user == null) {
      throw InvalidTokenException();
    }
    return user;
  }
}