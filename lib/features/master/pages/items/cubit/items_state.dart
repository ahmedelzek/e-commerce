import 'package:e_commerce/domain/entities/category/category_entity.dart';
import 'package:e_commerce/domain/entities/product/product_entity.dart';

abstract class ItemsState {}

class ItemsInitialState extends ItemsState {}
class ItemsLoadingState extends ItemsState {}

class ItemsErrorState extends ItemsState {
  final String error;
  ItemsErrorState({required this.error});
}

class ItemsSuccessState extends ItemsState {
  final List<CategoryEntity> categories;
  final List<ProductEntity> products;
  ItemsSuccessState({required this.categories, required this.products});
}