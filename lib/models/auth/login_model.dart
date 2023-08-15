// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:travel_plan/models/user/user_model.dart';

class LoginModel {
  UserModel? user;
  String? accessToken;
  LoginModel({
    this.user,
    this.accessToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'user': user?.toJson(),
    };
  }
}
