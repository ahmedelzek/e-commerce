import 'package:e_commerce/domain/entities/product/product_entity.dart';

class CategoryEntity {
  final int id;
  final String title;
  final String description;
  final String imagePath;
  final List<ProductEntity> products;

  const CategoryEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.products
  });
}