import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:travel_plan/controller/profile/profile_controller.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch(context.request.method) {
    HttpMethod.get => ProfileController.instance.getProfile(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}
