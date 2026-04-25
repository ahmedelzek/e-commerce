import '../../../domain/entities/user/user_response_entity.dart';
import 'user_model.dart';

class UserResponseModel extends UserResponseEntity {
  const UserResponseModel({
    required super.status,
    required super.user,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel(
        status: json['status'],
        user: UserModel.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'user': (user as UserModel).toJson(),
  };
}