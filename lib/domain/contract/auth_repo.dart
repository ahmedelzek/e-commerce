import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/entities/user_entity.dart';

abstract class AuthRepo {

  Future<Either<String, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<String, String>> register({
    required String name,
    required String email,
    required String password,
    required double phone,
  });
}
