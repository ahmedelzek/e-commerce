import 'package:e_commerce/domain/use_cases/get_categories_use_case.dart';
import 'package:e_commerce/domain/entities/product/product_entity.dart';
import 'package:e_commerce/domain/entities/category/category_entity.dart';
import 'package:e_commerce/features/master/pages/items/cubit/items_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsCubit extends Cubit<ItemsState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  ItemsCubit({required this.getCategoriesUseCase}) : super(ItemsInitialState());

  static ItemsCubit get(context) => BlocProvider.of(context);

  List<CategoryEntity> categories = [];
  int selectedCategoryIndex = 0;

  List<ProductEntity> get currentProducts =>
      categories.isNotEmpty
          ? categories[selectedCategoryIndex].products
          : [];

  Future<void> init() async {
    emit(ItemsLoadingState());
    final result = await getCategoriesUseCase.call();
    result.fold(
          (error) => emit(ItemsErrorState(error: error)),
          (response) {
        categories = response.categories;
        emit(ItemsSuccessState(
          categories: categories,
          products: currentProducts,
        ));
      },
    );
  }

  void selectCategory(int index) {
    selectedCategoryIndex = index;
    emit(ItemsSuccessState(
      categories: categories,
      products: currentProducts,
    ));
  }
}