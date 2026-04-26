import 'package:dartz/dartz.dart';

import '../contract/product_repo.dart';
import '../entities/product/product_entity_response.dart';

class GetProductsByCategoryUseCase {
  final ProductRepo repo;
  GetProductsByCategoryUseCase({required this.repo});

  Future<Either<String, ProductResponseEntity>> call(
      int categoryId,
      ) => repo.getProductsByCategory(categoryId);
}