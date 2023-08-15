// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dart_frog/dart_frog.dart';

class APIResponse<T> {
  bool success;
  String message;
  T? data;
  APIResponse({
    required this.success,
    required this.message,
    this.data,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'success': success,
      'message': message,
    };
    if (data != null) {
      json['data'] = data;
    }
    return json;
  }

  static Response unauthorized() {
    return Response.json(
      statusCode: 401,
      body: APIResponse<String>(
        success: false,
        message: 'Unauthorized',
      ),
    );
  }
}
