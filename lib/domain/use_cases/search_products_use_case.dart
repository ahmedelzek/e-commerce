import 'package:dartz/dartz.dart';

import '../contract/product_repo.dart';
import '../entities/product/product_entity_response.dart';

class SearchProductsUseCase {
  final ProductRepo repo;
  SearchProductsUseCase({required this.repo});

  Future<Either<String, ProductResponseEntity>> call(
      String query,
      ) => repo.searchProducts(query);
}