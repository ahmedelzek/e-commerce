import 'category_entity.dart';

class CategoryResponseEntity {
  final bool status;
  final List<CategoryEntity> categories;

  const CategoryResponseEntity({
    required this.status,
    required this.categories,
  });
}