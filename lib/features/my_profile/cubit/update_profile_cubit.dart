import 'dart:io';

import 'package:e_commerce/domain/use_cases/update_profile_use_case.dart';
import 'package:e_commerce/features/my_profile/cubit/update_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileUseCase updateProfileUseCase;

  UpdateProfileCubit({required this.updateProfileUseCase})
      : super(UpdateProfileInitialState());

  static UpdateProfileCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  String? imagePath;

  updateProfile() async {
    if (formKey.currentState?.validate() == false) return;
    emit(UpdateProfileLoadingState());

    var result = await updateProfileUseCase.call(
      name: name.text.trim(),
      phone: phone.text.trim(),
      imagePath: imagePath
    );
    result.fold((error) => emit(UpdateProfileErrorState(error: error)), (
        success) => emit(UpdateProfileSuccessState(success: success)));
  }
}
