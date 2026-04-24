import '../category/category_entity.dart';

class ProductEntity {
  final int id;
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final double rating;
  final bool isFavorite;
  final int bestSeller;
  final CategoryEntity category;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.rating,
    required this.isFavorite,
    required this.bestSeller,
    required this.category,
  });
}