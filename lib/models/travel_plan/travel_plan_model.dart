// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:travel_plan/models/user/user_model.dart';

class TravelPlanModel {
  String? id;
  String? title;
  String? description;
  double? latitude;
  double? longitude;
  String? planDate;
  int? budget;
  String? userId;
  UserModel? user;
  TravelPlanModel({
    this.id,
    this.title,
    this.description,
    this.latitude,
    this.longitude,
    this.planDate,
    this.budget,
    this.userId,
    this.user,
  });

  factory TravelPlanModel.fromRowAssoc(Map<String, dynamic> row) =>
    TravelPlanModel(
      id: row['id'] as String?,
      title: row['title'] as String?,
      description: row['description'] as String?,
      latitude: row['latitude'] != null ? double.parse(row['latitude'].toString()) : 0,
      longitude: row['longitude'] != null ? double.parse(row['longitude'].toString()) : 0,
      planDate: row['plan_date'] as String?,
      budget: row['budget'] != null ? int.parse(row['budget'].toString()) : 0,
      userId: row['user_id'] as String?,
      user: row['user_name'] != null ? UserModel.fromJsonJoin(row) : null,
    ); 

  factory TravelPlanModel.fromJson(Map<String, dynamic> json) =>
    TravelPlanModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
      planDate: json['plan_date'] as String,
      budget: json['budget'] as int?,
      userId: json['user_id'] as String?,
      user: UserModel.fromJsonJoin(json),
    );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'plan_date': planDate,
      'budget': budget,
      'user': user?.toJson(),
    };
  }
}
