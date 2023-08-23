import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:travel_plan/controller/travel/travel_controller.dart';

///
/// The /api/travel/[id] routes
///
/// @Allow(GET) - Allow only GET methods
///
/// @Security(Bearer) - The security key
///
///
Future<Response> onRequest(RequestContext context, String id) async {
  return switch(context.request.method) {
    HttpMethod.get => TravelController.instance.getById(context, id),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}
