import 'package:e_commerce/domain/entities/category/category_entity.dart';
import 'package:e_commerce/domain/entities/product/product_entity.dart';
import 'package:e_commerce/domain/entities/slider/slider_entity.dart';
import 'package:e_commerce/domain/use_cases/get_categories_use_case.dart';
import 'package:e_commerce/domain/use_cases/get_products_use_case.dart';
import 'package:e_commerce/domain/use_cases/get_sliders_use_case.dart';
import 'package:e_commerce/features/master/pages/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetSliderUseCase getSliderUseCase;
  final GetProductsUseCase getProductsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  HomeCubit({
    required this.getSliderUseCase,
    required this.getProductsUseCase,
    required this.getCategoriesUseCase,
  }) : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  List<SliderEntity>? sliders;
  List<ProductEntity>? products;
  List<CategoryEntity>? categories;
  int currentIndex = 0;

  getData() async {
    emit(HomeLoadingState());

    final slidersResult = await getSliderUseCase.call();
    final productsResult = await getProductsUseCase.call();
    final categoryResult = await getCategoriesUseCase.call();

    String? errorMessage;

    slidersResult.fold(
          (error) => errorMessage = error,
          (slidersData) => sliders = slidersData.sliders,
    );

    productsResult.fold(
          (error) => errorMessage = error,
          (productsData) => products = productsData.products,
    );

    categoryResult.fold(
          (error) => errorMessage = error,
          (categoriesData) => categories = categoriesData.categories,
    );

    if (errorMessage != null) {
      emit(HomeErrorState(error: errorMessage!));
    } else if (sliders != null && products != null && categories != null) {
      emit(HomeSuccessState());
    }
  }

  void updateIndex(int index) {
    currentIndex = index;
    emit(HomeSuccessState());
  }
  List<ProductEntity> get favoriteProducts {
    return products
        ?.where((product) => product.isFavorite == true)
        .toList() ??
        [];
  }
}
