
// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_frog/dart_frog.dart';
import 'package:travel_plan/models/auth/login_model.dart';
import 'package:travel_plan/models/response/api_response.dart';
import 'package:travel_plan/repository/user/user_repository.dart';
import 'package:travel_plan/rules/auth/rules_auth.dart';
import 'package:travel_plan/utils/password/password_hash_utils.dart';
import 'package:travel_plan/validation/validation.dart';
import 'package:uuid/uuid.dart';

/// Auth controller
class AuthController {
  /// Constructor
  factory AuthController() {
    return instance;
  }
  AuthController._internal();
  /// Singleton instance
  static final AuthController instance = AuthController._internal();

  /// Login user
  Future<Response> login(RequestContext context) async {
    final userRepository = context.read<UserRepository>();
    final data = await context.request.json() as Map<String, dynamic>;

    /// Validation
    final validation = Validations.setRules(data, RulesAuth.login);
    final validateErrors = validation.validate();
    if (validateErrors.isNotEmpty) {
      return Response.json(
        statusCode: 400,
        body: APIResponse<List<String>>(
          success: false,
          message: 'Validation error',
          data: validateErrors,
        ),
      );
    }

    /// Login user
    final result = await userRepository.login(data['email'] as String, data['password'] as String);
    if (result != null) {
      return Response.json(
        body: APIResponse<LoginModel>(
          success: true,
          message: 'Successfully login',
          data: result,
        ),
      );
    } else {
      return Response.json(
        statusCode: 401,
        body: APIResponse<String>(
          success: false,
          message: 'Email or password is wrong',
        ),
      );
    }
  }

  /// Register user
  Future<Response> register(RequestContext context) async {
    final userRepository = context.read<UserRepository>();
    final data = await context.request.json() as Map<String, dynamic>;

    final validation = Validations.setRules(data, RulesAuth.register);
    final validateErrors = validation.validate();
    if (validateErrors.isNotEmpty) {
      return Response.json(
        statusCode: 400,
        body: APIResponse<List<String>>(
          success: false,
          message: 'Validation error',
          data: validateErrors,
        ),
      );
    }

    /// Check if email already exists
    final user = await userRepository.getUserByEmail(data['email'] as String);
    if (user == null) {
      /// Hashing password
      data['password'] = PasswordHashUtils.hashPassword(data['password'] as String);
      /// Set id
      const uuid = Uuid();
      data['id'] = uuid.v4();

      final newUser = await userRepository.register(data);
      if (newUser != null) {
        return Response.json(
          statusCode: 201,
          body: APIResponse(
            success: true,
            message: 'Successfully register account',
            data: newUser,
          ),
        );
      }
      return Response.json(
        statusCode: 400,
        body: APIResponse<String>(
          success: false,
          message: 'Failed to register account',
        ),
      );
    } else {
      return Response.json(
        statusCode: 400,
        body: APIResponse<String>(
          success: false,
          message: 'Email already exists',
        ),
      );
    }
  }


}
