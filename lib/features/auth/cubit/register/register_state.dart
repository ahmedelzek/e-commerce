abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState({required this.error});
}

class RegisterSuccessState extends RegisterState {
  final String success;

  RegisterSuccessState({required this.success});
}
