
import 'package:dart_frog/dart_frog.dart';
import 'package:travel_plan/models/response/api_response.dart';
import 'package:travel_plan/models/user/user_model.dart';
import 'package:travel_plan/repository/user/user_repository.dart';
import 'package:travel_plan/utils/jwt/jwt_utils.dart';

/// Auth middleware
class AuthMiddleware {

  /// Middleware token
  static Middleware token({bool getMethodNoAuth = true}) {
    return (handler) {
      return (context) async {
        /// Disable middleware auth for get
        if (getMethodNoAuth && context.request.method == HttpMethod.get) {
          return handler(context);
        }

        final headers = context.request.headers;
        if (!headers.containsKey('Authorization')) {
          return APIResponse.unauthorized();
        }
        final token = headers['Authorization'].toString().split(' ').last;
        try {
          if (!JWTUtils.verifyAccessToken(accessToken: token)) {
            return APIResponse.unauthorized();
          }

          final userId = JWTUtils.getUserIdFromToken(accessToken: token);
          final userRepository = context.read<UserRepository>();
          final user = await userRepository.getUserById(userId);
          return handler(context.provide<UserModel?>(() => user));
        } catch(e) {
          return APIResponse.unauthorized();
        }
      };
    };
  }
}
