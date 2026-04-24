import 'package:carousel_slider/carousel_controller.dart';
import 'package:e_commerce/domain/entities/product/product_entity.dart';
import 'package:e_commerce/domain/entities/slider/slider_entity.dart';
import 'package:e_commerce/domain/use_cases/get_products_use_case.dart';
import 'package:e_commerce/domain/use_cases/get_sliders_use_case.dart';
import 'package:e_commerce/features/master/pages/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetSliderUseCase getSliderUseCase;
  final GetProductsUseCase getProductsUseCase;

  HomeCubit({required this.getSliderUseCase, required this.getProductsUseCase})
    : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  List<SliderEntity>? sliders;
  List<ProductEntity>? products;
  int currentIndex = 0;

  getData() async {
    emit(HomeLoadingState());

    final slidersResult = await getSliderUseCase.call();
    final productsResult = await getProductsUseCase.call();

    slidersResult.fold(
          (error) => emit(HomeErrorState(error: error)),
          (slidersData) => sliders = slidersData.sliders,
    );

    productsResult.fold(
          (error) => emit(HomeErrorState(error: error)),
          (productsData) => products = productsData.products,
    );

    if (sliders != null && products != null) {
      emit(HomeSuccessState());
    }
  }



  void updateIndex(int index) {
    currentIndex = index;
    emit(HomeSuccessState());
  }
}
