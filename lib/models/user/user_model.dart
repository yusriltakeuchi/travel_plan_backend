// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String? id;
  String? email;
  String? password;
  String? name;
  UserModel({
    this.id,
    this.email,
    this.password,
    this.name,
  });

  factory UserModel.fromRowAssoc(Map<String, dynamic> row) =>
    UserModel(
      id: row['id'] as String?,
      email: row['email'] as String?,
      password: row['password'] as String?,
      name: row['name'] as String?,
    );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
    UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
    );

  factory UserModel.fromJsonJoin(Map<String, dynamic> json) =>
    UserModel(
      id: json['user_id'] as String?,
      email: json['user_email'] as String?,
      name: json['user_name'] as String?,
    );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

}
