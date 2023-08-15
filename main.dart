import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:travel_plan/database/database.dart';

final dbClient = DBClient();
Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  /// Inject database client
  return serve(handler.use(dBHandler()), ip, port);
}

Middleware dBHandler() {
  return (handler) {
    return handler.use(
      provider<DBClient>((context) => dbClient),
    );
  };
}
