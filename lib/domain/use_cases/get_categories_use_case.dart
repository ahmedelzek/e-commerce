import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/contract/category_repo.dart';
import 'package:e_commerce/domain/entities/category/category_response_entity.dart';

class GetCategoriesUseCase{
  final CategoryRepo repo;
  GetCategoriesUseCase({required this.repo});

  Future<Either<String, CategoryResponseEntity>> call()=> repo.getCategories();
}