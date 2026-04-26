import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/entities/product/product_entity_response.dart';

abstract class ProductRepo {
  Future<Either<String, ProductResponseEntity>> getProducts();
  Future<Either<String, ProductResponseEntity>> getProductsByCategory(int categoryId);

}