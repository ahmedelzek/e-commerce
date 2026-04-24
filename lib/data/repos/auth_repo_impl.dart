import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/cache/cache_keys.dart';
import 'package:e_commerce/core/network/api_helper.dart';
import 'package:e_commerce/core/network/end_points.dart';
import 'package:e_commerce/data/models/auth/login_model.dart';
import 'package:e_commerce/data/models/auth/register_model.dart';
import 'package:e_commerce/domain/entities/user/user_entity.dart';
import 'package:e_commerce/domain/contract/auth_repo.dart';

import '../../core/cache/cache_helper.dart';
import '../../core/network/api_response.dart';

class AuthRepoImpl extends AuthRepo {
  final APIHelper apiHelper;

  AuthRepoImpl({required this.apiHelper});

  @override
  Future<Either<String, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      var loginResponse = await apiHelper.postRequest(
        endPoint: EndPoints.login,
        data: {'email': email, 'password': password},
      );

      if (loginResponse.status) {
        // serialization
        var loginResponseModel = LoginModel.fromJson(
          loginResponse.data as Map<String, dynamic>,
        );

        // save tokens
        await CacheHelper.setValue(
          CacheKeys.accessToken,
          loginResponseModel.accessToken,
        );
        await CacheHelper.setValue(
          CacheKeys.refreshToken,
          loginResponseModel.refreshToken,
        );

        return Right(loginResponseModel.user);
      } else {
        return left(loginResponse.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }

  @override
  Future<Either<String, String>> register({
    required String name,
    required String email,
    required String password,
    required double phone,
  }) async {
    try {
      var registerResponse = await apiHelper.postRequest(
        endPoint: EndPoints.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        },
      );

      if (registerResponse.status) {
        // serialization
        var registerModel = RegisterModel.fromJson(
          registerResponse.data as Map<String, dynamic>,
        );

        return Right(registerModel.message);
      } else {
        return left(registerResponse.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }
}
