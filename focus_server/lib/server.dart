import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:focus_server/src/custom_scope.dart';
import 'package:focus_server/src/future_calls/routine_completion_check_future_call.dart';
import 'package:serverpod/serverpod.dart';

import 'package:focus_server/src/web/routes/root.dart';

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

/// Run our server.
void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: (Session session, String token) async {
      if (token.isEmpty) {
        return null;
      }
      if (session.endpoint == 'auth' && session.method != 'refresh') {
        return await _validateClerkToken(session, token);
      }
      return await _validateFocusToken(session, token);
    },
  );

  // If you are using any future calls, they need to be registered here.
  pod.registerFutureCall(
    RoutineCompletionCheckFutureCall(),
    RoutineCompletionCheckFutureCall.callName,
  );

  // Setup a default page at the web root.
  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');
  // Serve all files in the /static directory.
  pod.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
    '/*',
  );

  // Start the server.
  await pod.start();
}

Future<AuthenticationInfo?> _validateClerkToken(Session session, String token) async {
  try {
    final pemString = await File(session.passwords['clerkJwtPem'] as String).readAsString();
    final jwt = JWT.verify(token, RSAPublicKey(pemString));
    final clerkId = jwt.payload['clerk_id'] as String;
    final user = await User.db.findFirstRow(
      session,
      where: (UserTable table) => table.clerkUserId.equals(clerkId),
    );
    return AuthenticationInfo(
      user != null ? user.id! : jwt.subject.hashCode,
      <Scope>{CustomScope.auth},
    );
  } catch (error, stackTrace) {
    session.log(
      'error in _validateClerkToken',
      level: LogLevel.error,
      exception: error,
      stackTrace: stackTrace,
    );
    return null;
  }
}

Future<AuthenticationInfo?> _validateFocusToken(Session session, String token) async {
  try {
    // FIXME(drexel-ue): replace with actual key.
    final secretKey = SecretKey('secret');
    final jwt = JWT.verify(token, secretKey);
    final userId = int.parse(jwt.subject!);
    // FIXME(drexel): replace with extension.
    final user = await User.db.findById(session, userId);
    if (user != null) {
      final scopes = jwt.payload['scopes'] //
          .split(', ')
          .map<CustomScope>(CustomScope.parse);
      return AuthenticationInfo(
        user.id!,
        Set<Scope>.from(scopes),
      );
    }
    return AuthenticationInfo(
      jwt.subject.hashCode,
      <Scope>{Scope.none},
    );
  } on JWTExpiredException catch (_) {
    throw ExpiredJWTException();
  } catch (error, stackTrace) {
    session.log(
      'error in _validateFocusToken',
      level: LogLevel.error,
      exception: error,
      stackTrace: stackTrace,
    );
    return null;
  }
}
