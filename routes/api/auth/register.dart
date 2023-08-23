import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:travel_plan/controller/auth/auth_controller.dart';

///
/// The /api/auth/register routes
///
/// @Allow(POST) - Allow only POST methods
///
/// @Body(register) - The registers data
///
Future<Response> onRequest(RequestContext context) async {
  return switch(context.request.method) {
    HttpMethod.post => AuthController.instance.register(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}
