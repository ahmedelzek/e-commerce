import 'dart:async';

import 'package:e_commerce/domain/entities/product/product_entity.dart';
import 'package:e_commerce/domain/use_cases/search_products_use_case.dart';
import 'package:e_commerce/features/search/cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchProductsUseCase searchUseCase;

  SearchCubit({required this.searchUseCase}) : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  List<ProductEntity> products = [];

  Timer? _debounce;

  void onQueryChanged(String query) {
    _debounce?.cancel();

    if (query.trim().isEmpty) {
      products = [];
      emit(SearchInitialState());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 400), () => search(query));
  }

  Future<void> search(String query) async {
    emit(SearchLoadingState());

    final result = await searchUseCase.call(query);

    result.fold(
          (error) => emit(SearchErrorState(error: error)),
          (data) {
        products = data.products;
        emit(SearchSuccessState());
      },
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}