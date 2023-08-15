
// ignore_for_file: lines_longer_than_80_chars

import 'package:travel_plan/database/database.dart';
import 'package:travel_plan/models/auth/login_model.dart';
import 'package:travel_plan/models/user/user_model.dart';
import 'package:travel_plan/utils/jwt/jwt_utils.dart';
import 'package:travel_plan/utils/password/password_hash_utils.dart';

/// Repository for user
class UserRepository {
  /// Constructor
  UserRepository(this._client);
  final DBClient _client;

  /// Login user
  Future<LoginModel?> login(String email, String password) async {
    final user = await getUserByEmail(email);
    if (user != null) {
      if (PasswordHashUtils.checkPassword(password, user.password ?? '')) {
        return LoginModel(
          accessToken: JWTUtils.generateAccessToken(userId: user.id ?? ''),
          user: user,
        );
      }
    }
    return null;
  }

  /// Register user
  Future<UserModel?> register(Map<String, dynamic> data) async {
    final result = await _client.execute(
      'INSERT INTO users (id, name, email, password) VALUES (:id, :name, :email, :password)',
      params: data,
    );
    if (result.affectedRows.toInt() == 1) {
      return UserModel.fromRowAssoc(data);
    }
    return null;
  }

  /// Get user by email
  Future<UserModel?> getUserByEmail(String email) async {
    final result = await _client.execute('SELECT * FROM users WHERE email = :email', params: {'email': email});
    if (result.rows.isNotEmpty) {
      return UserModel.fromRowAssoc(result.rows.first.assoc());
    }
    return null;
  }

  /// Get user by id
  Future<UserModel?> getUserById(String id) async {
    final result = await _client.execute('SELECT * FROM users WHERE id = :id', params: {'id': id});
    if (result.rows.isNotEmpty) {
      return UserModel.fromRowAssoc(result.rows.first.assoc());
    }
    return null;
  }
}
