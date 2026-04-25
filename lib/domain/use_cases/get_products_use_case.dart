import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/contract/product_repo.dart';
import 'package:e_commerce/domain/entities/product/product_entity_response.dart';

class GetProductsUseCase {
  final ProductRepo repo;

  GetProductsUseCase({required this.repo});

  Future<Either<String, ProductResponseEntity>> call() => repo.getProducts();
}
