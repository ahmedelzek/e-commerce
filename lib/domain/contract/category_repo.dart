import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/entities/category/category_response_entity.dart';

abstract class CategoryRepo{
  Future<Either<String, CategoryResponseEntity>> getCategories();
}