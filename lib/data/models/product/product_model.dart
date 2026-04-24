import '../../../domain/entities/product/product_entity.dart';
import '../category/category_model.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imagePath,
    required super.price,
    required super.rating,
    required super.isFavorite,
    required super.bestSeller,
    required super.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      imagePath: json['image_path'] as String,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      isFavorite: json['is_favorite'] as bool,
      bestSeller: json['best_seller'] as int,
      category: CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_path': imagePath,
      'price': price,
      'rating': rating,
      'is_favorite': isFavorite,
      'best_seller': bestSeller,
      'category': (category as CategoryModel).toJson(),
    };
  }
}