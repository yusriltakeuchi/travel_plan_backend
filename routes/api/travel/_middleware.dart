
// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_frog/dart_frog.dart';
import 'package:travel_plan/middleware/auth_middleware.dart';

Handler middleware(Handler handler) {
  return handler
    .use(requestLogger())
    .use(AuthMiddleware.token());
}
