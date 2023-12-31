// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:travel_plan/controller/auth/auth_controller.dart';

///
/// The /api/auth/login routes
///
/// @Allow(POST) - Allow only POST methods
///
/// @Body(login) - The login data
///
Future<Response> onRequest(RequestContext context) async {
  return switch(context.request.method) {
    HttpMethod.post => AuthController.instance.login(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}
