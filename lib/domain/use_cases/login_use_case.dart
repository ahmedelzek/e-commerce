import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/entities/user_entity.dart';
import 'package:e_commerce/domain/repos/auth_repo.dart';

class LoginUseCase {
  final AuthRepo repo;

  LoginUseCase({required this.repo});

  Future<Either<String, UserEntity>> call({
    required String email,
    required String password,
  }) => repo.login(email: email, password: password);
}
