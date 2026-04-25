import '../../../domain/entities/category/category_response_entity.dart';
import 'category_model.dart';

class CategoryResponseModel extends CategoryResponseEntity {
  const CategoryResponseModel({
    required super.status,
    required super.categories,
  });

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoryResponseModel(
      status: json['status'] as bool,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}