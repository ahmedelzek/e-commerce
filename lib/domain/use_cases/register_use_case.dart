import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/repos/auth_repo.dart';

class RegisterUseCase {
  final AuthRepo repo;

  RegisterUseCase({required this.repo});

  Future<Either<String, String>> call({
    required String name,
    required String email,
    required String password,
    required double phone,
  }) =>
      repo.register(name: name, email: email, password: password, phone: phone);
}
