import 'package:e_commerce/domain/entities/login_entity.dart';

import 'user_model.dart';

class LoginModel extends LoginEntity {
  const LoginModel({
    required super.accessToken,
    required super.refreshToken,
    required super.status,
    required super.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      status: json['status'] as bool,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'status': status,
      'user': (user as UserModel).toJson(),
    };
  }
}
