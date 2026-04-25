abstract class UpdateProfileState {}

class UpdateProfileInitialState extends UpdateProfileState {}

class UpdateProfileLoadingState extends UpdateProfileState {}

class UpdateProfileErrorState extends UpdateProfileState {
  final String error;
  UpdateProfileErrorState({required this.error});
}

class UpdateProfileSuccessState extends UpdateProfileState {
  final String success;
  UpdateProfileSuccessState({required this.success});
}
