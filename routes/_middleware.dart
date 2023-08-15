
import 'package:dart_frog/dart_frog.dart';
import 'package:travel_plan/database/database.dart';
import 'package:travel_plan/repository/travel/travel_repository.dart';
import 'package:travel_plan/repository/user/user_repository.dart';

Handler middleware(Handler handler) {
  return handler
    .use(requestLogger())
    .use(injectionHandler());
}

Middleware injectionHandler() {
  return (handler) {
    return handler
      .use(provider<TravelRepository>(
        (context) => TravelRepository(
          context.read<DBClient>(),
        ),
      ),)
      .use(provider<UserRepository>(
        (context) => UserRepository(
          context.read<DBClient>(),
        ),
      ),);
  };
}
