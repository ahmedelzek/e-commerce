import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/entities/user/update_profile_response_entity.dart';
import 'package:e_commerce/domain/entities/user/user_response_entity.dart';

abstract class UserRepo {
  Future<Either<String, UserResponseEntity>> getUser();

  Future<Either<String, String>> updateUser({
    required String name,
    required double phone,
    String? imagePath,
  });
}
