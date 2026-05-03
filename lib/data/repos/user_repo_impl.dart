import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/core/network/api_helper.dart';
import 'package:e_commerce/data/models/user/update_profile_response_model.dart';
import 'package:e_commerce/data/models/user/user_response_model.dart';
import 'package:e_commerce/domain/contract/user_repo.dart';
import 'package:e_commerce/domain/entities/user/user_response_entity.dart';

import '../../core/network/api_response.dart';
import '../../core/network/end_points.dart';

class UserRepoImpl extends UserRepo {
  final APIHelper apiHelper;

  UserRepoImpl({required this.apiHelper});

  @override
  Future<Either<String, UserResponseEntity>> getUser() async {
    try {
      var result = await apiHelper.getRequest(endPoint: EndPoints.user);

      if (result.status) {
        var userResponse = UserResponseModel.fromJson(
          result.data as Map<String, dynamic>,
        );

        return Right(userResponse);
      } else {
        return left(result.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }

  @override
  Future<Either<String, String>> updateUser({
    required String name,
    required String phone,
    String? imagePath,
  }) async {
    try {
      final data = <String, dynamic>{
        "name": name,
        "phone": phone,
        if(imagePath !=null)
          "image": await MultipartFile.fromFile(
            imagePath,
            filename: imagePath.split('/').last,
          )
      };
      var result = await apiHelper.putRequest(
        endPoint: EndPoints.updateProfile,
        data: data
      );

      if (result.status) {
        var response = UpdateProfileResponseModel.fromJson(
          result.data as Map<String, dynamic>,
        );

        return Right(response.message);
      } else {
        return left(result.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }
}
