// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:travel_plan/controller/travel/travel_controller.dart';

///
/// The /api/travel routes
///
/// @Allow(GET, POST) - Allow only GET and POST methods
///
/// @Security(Bearer) - The security key
///
/// @Body(travel) - Travel create data
///
Future<Response> onRequest(RequestContext context) async {
  return switch(context.request.method) {
    HttpMethod.post => TravelController.instance.create(context),
    HttpMethod.get => TravelController.instance.getAll(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}
