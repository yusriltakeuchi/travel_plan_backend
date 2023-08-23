import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:travel_plan/controller/profile/profile_controller.dart';

///
/// The /api/profile routes
///
/// @Allow(GET) - Allow only GET methods
///
/// @Security(Bearer) - The security key
///
///
Future<Response> onRequest(RequestContext context) async {
  return switch(context.request.method) {
    HttpMethod.get => ProfileController.instance.getProfile(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}
