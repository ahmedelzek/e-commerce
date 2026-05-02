import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/add_to_favorite_use_case.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final AddToFavoriteUseCase addToFavoriteUseCase;

  FavoriteCubit({required this.addToFavoriteUseCase, required bool isFavorite})
    : super(FavoriteInitialState(isFavorite: isFavorite));

  static FavoriteCubit get(context) => BlocProvider.of(context);


  bool _isFavorite = false;

  void init(bool isFavorite) {
    _isFavorite = isFavorite;
    emit(FavoriteInitialState(isFavorite: _isFavorite));
  }

  Future<void> addToFavorite(int productId) async {
    emit(FavoriteLoadingState());

    final result = await addToFavoriteUseCase.call(productId);

    result.fold((error) => emit(FavoriteErrorState(error: error)), (success) {
      _isFavorite = !_isFavorite;
      emit(FavoriteSuccessState(success: success, isFavorite: _isFavorite));
    });
  }
}
