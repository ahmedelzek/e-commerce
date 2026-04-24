import 'product_entity.dart';

class ProductResponseEntity {
  final bool status;
  final List<ProductEntity> products;

  const ProductResponseEntity({
    required this.status,
    required this.products,
  });
}