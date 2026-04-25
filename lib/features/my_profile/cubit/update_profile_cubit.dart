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

  updateProfile() async {
    if (formKey.currentState?.validate() == false) return;
    emit(UpdateProfileLoadingState());
    final double? phoneNumber = double.tryParse(phone.text.trim());

    var result = await updateProfileUseCase.call(
      name: name.text.trim(),
      phone: phoneNumber ?? 0,
    );
    result.fold((error) => emit(UpdateProfileErrorState(error: error)), (
        success) => emit(UpdateProfileSuccessState(success: success)));
  }
}
