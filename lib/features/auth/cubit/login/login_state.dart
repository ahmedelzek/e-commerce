import 'package:e_commerce/domain/entities/user_entity.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState({required this.error});
}

class LoginSuccessState extends LoginState {
  final UserEntity user;
  LoginSuccessState({required this.user});
}
