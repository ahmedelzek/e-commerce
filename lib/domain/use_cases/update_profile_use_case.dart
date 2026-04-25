import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/contract/user_repo.dart';

class UpdateProfileUseCase {
  final UserRepo repo;

  UpdateProfileUseCase({required this.repo});

  Future<Either<String, String>> call(
      {required String name, required double phone}) =>
      repo.updateUser(name: name, phone: phone);
}