abstract class FavoriteState {}

class FavoriteInitialState extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteErrorState extends FavoriteState {
  final String error;
  FavoriteErrorState({required this.error});
}

class FavoriteSuccessState extends FavoriteState {
  final String success;
  FavoriteSuccessState({required this.success});
}
