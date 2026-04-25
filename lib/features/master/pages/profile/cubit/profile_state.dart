import 'package:e_commerce/domain/entities/user/user_entity.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String error;
  ProfileErrorState({required this.error});
}

class ProfileSuccessState extends ProfileState {
  final UserEntity user ;
  ProfileSuccessState({required this.user});
}
