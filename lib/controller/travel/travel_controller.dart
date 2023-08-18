
// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_frog/dart_frog.dart';
import 'package:travel_plan/models/response/api_response.dart';
import 'package:travel_plan/models/travel_plan/travel_plan_model.dart';
import 'package:travel_plan/models/user/user_model.dart';
import 'package:travel_plan/repository/travel/travel_repository.dart';
import 'package:travel_plan/rules/travel/rules_travel.dart';
import 'package:travel_plan/validation/validation.dart';
import 'package:uuid/uuid.dart';

/// Travel controller
class TravelController {
  /// Constructor
  factory TravelController() {
    return instance;
  }
  TravelController._internal();
  /// Singleton instance
  static final TravelController instance = TravelController._internal();

  /// Get all travel plans
  Future<Response> getAll(RequestContext context) async {
    final travelRepository = context.read<TravelRepository>();
    final travelPlans = await travelRepository.getPlans();
    return Response.json(
      body: APIResponse<List<TravelPlanModel>>(
        success: true,
        message: 'Successfully get travel plan',
        data: travelPlans,
      ),
    );
  }

  /// Get travel plan by id
  Future<Response> getById(RequestContext context, String id) async {
    final travelRepository = context.read<TravelRepository>();
    final travelPlan = await travelRepository.getPlan(id);
    if (travelPlan.id != null) {
      return Response.json(
        body: APIResponse(
          success: true,
          message: 'Successfully get travel plan',
          data: travelPlan,
        ),
      );
    }
    return Response.json(
      statusCode: 404,
      body: APIResponse<String>(
        success: false,
        message: 'Travel plan not found',
      ),
    );
  }

  /// Create travel plan
  Future<Response> create(RequestContext context) async {
    final travelRepository = context.read<TravelRepository>();
    final data = await context.request.json() as Map<String, dynamic>;

    final validateErrors = Validations
      .setRules(data, RulesTravel.create)
      .validate();
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

    /// Get user from auth
    final user = context.read<UserModel?>();
    data['user_id'] = user?.id;

    const uuid = Uuid();
    data['id'] = uuid.v4();
    final travelPlan = await travelRepository.createPlans(data);
    
    if (travelPlan != null) {
      return Response.json(
        statusCode: 201,
        body: APIResponse<TravelPlanModel>(
          success: true,
          message: 'Successfully create travel plan',
          data: travelPlan,
        ),
      );
    }
    return Response.json(
      statusCode: 400,
      body: APIResponse<String>(
        success: false,
        message: 'Failed to create travel plan',
      ),
    );
  }


}
