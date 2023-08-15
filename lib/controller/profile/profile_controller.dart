import 'package:dart_frog/dart_frog.dart';
import 'package:travel_plan/models/response/api_response.dart';
import 'package:travel_plan/models/user/user_model.dart';

/// Profile controller
class ProfileController {
    /// Constructor
  factory ProfileController() {
    return instance;
  }
  ProfileController._internal();
  /// Singleton instance
  static final ProfileController instance = ProfileController._internal();

  /// Get profile
  Future<Response> getProfile(RequestContext context) async {
    /// Get user from auth
    final user = context.read<UserModel?>();
    return Response.json(
      body: APIResponse(
        success: true,
        message: 'Successfully get profile',
        data: user,
      ),
    );
  }
}
