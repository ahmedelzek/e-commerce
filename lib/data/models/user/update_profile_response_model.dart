import '../../../domain/entities/user/update_profile_response_entity.dart';

class UpdateProfileResponseModel extends UpdateProfileResponseEntity {
  const UpdateProfileResponseModel({
    required super.status,
    required super.message,
  });

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponseModel(
        status: json['status'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
  };
}