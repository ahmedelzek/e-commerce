
import 'package:e_commerce/domain/entities/auth/register_entity.dart';

class RegisterModel extends RegisterEntity {
  const RegisterModel({
    required super.message,
    required super.status,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      message: json['message'] ?? '',
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
    };
  }
}