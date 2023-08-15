import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

/// JWT constants
class JWTUtils {
  static const _secretKey = 'yurani1234';
  /// Generate access token
   static String generateAccessToken({required String userId}) {
    final jwt = JWT({
      'userId': userId,
    });
    return jwt.sign(
      SecretKey(_secretKey),
      expiresIn: const Duration(minutes: 1),
    );
  }

  /// Verify access token valid
  static bool verifyAccessToken({required String accessToken}) {
    try {
      JWT.verify(accessToken, SecretKey(_secretKey));
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Get user id from access token
  static String getUserIdFromToken({required String accessToken}) {
    final jwt = JWT.decode(accessToken);
    // ignore: avoid_dynamic_calls
    return jwt.payload['userId'] as String;
  }
}
