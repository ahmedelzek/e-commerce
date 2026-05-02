abstract class FavoriteState {}

class FavoriteInitialState extends FavoriteState {
  final bool isFavorite ;
  FavoriteInitialState({required this.isFavorite});
}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteErrorState extends FavoriteState {
  final String error;
  FavoriteErrorState({required this.error});
}

class FavoriteSuccessState extends FavoriteState {
  final String success;
  final bool isFavorite;
  FavoriteSuccessState({required this.success,required this.isFavorite});
}
