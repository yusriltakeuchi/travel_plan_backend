
// ignore_for_file: lines_longer_than_80_chars

import 'package:travel_plan/database/database.dart';
import 'package:travel_plan/models/travel_plan/travel_plan_model.dart';

/// Repository for travel plan
class TravelRepository {
  /// Constructor
  TravelRepository(this._client);
  final DBClient _client;

  /// Get all travel plans
  Future<List<TravelPlanModel>> getPlans() async {
    final result = await _client.execute('''
SELECT 
	travel_plan.*,
    users.id as user_id, 
    users.email as user_email,
    users.name as user_name
FROM 
	travel_plan
join users on travel_plan.user_id = users.id;''');
    final travelPlans = <TravelPlanModel>[];
    if (result.rows.isNotEmpty) {
      for (final row in result.rows) {
        travelPlans.add(TravelPlanModel.fromRowAssoc(row.assoc()));
      }
      return travelPlans;
    }
    return travelPlans;
  }

  /// Get travel plan by id
  Future<TravelPlanModel> getPlan(String id) async {
    final result = await _client.execute('''
SELECT 
	travel_plan.*,
  users.id as user_id, 
  users.email as user_email,
  users.name as user_name
FROM 
	travel_plan
join users on travel_plan.user_id = users.id WHERE travel_plan.id = :id;''', params: {'id': id},);
    if (result.rows.isNotEmpty) {
      return TravelPlanModel.fromRowAssoc(result.rows.first.assoc());
    }
    return TravelPlanModel();
  }

  /// Create travel plan
  Future<TravelPlanModel?> createPlans(Map<String, dynamic> data) async {
    final result = await _client.execute(
      'INSERT INTO travel_plan (id, title, description, latitude, longitude, plan_date, budget, user_id) VALUES (:id, :title, :description, :latitude, :longitude, :plan_date, :budget, :user_id)',
      params: data,
    );
    if (result.affectedRows.toInt() == 1) {
      return TravelPlanModel.fromRowAssoc(data);
    }
    return null;
  }
}
