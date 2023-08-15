
import 'package:bcrypt/bcrypt.dart';

/// {@template password_hasher_service}
class PasswordHashUtils {
  /// {@macro password_hasher_service}
  const PasswordHashUtils();

  /// Hashes the given [password].
  /// The returned [Future] completes with the hashed password.
  static String hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  /// Checks if the given [password] matches the given [hashedPassword].
  /// The returned [Future] completes with `true` if the password matches the
  /// hashed password, otherwise it completes with `false`.

  static bool checkPassword(String password, String hashedPassword) {
    return BCrypt.checkpw(password, hashedPassword);
  }
}
