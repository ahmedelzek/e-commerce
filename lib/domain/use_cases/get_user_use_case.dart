import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/contract/user_repo.dart';
import 'package:e_commerce/domain/entities/user/user_response_entity.dart';

class GetUserUseCase {
  final UserRepo repo;

  GetUserUseCase({required this.repo});

  Future<Either<String, UserResponseEntity>> getUser() => repo.getUser();
}
