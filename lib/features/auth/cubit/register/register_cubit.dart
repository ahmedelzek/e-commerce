import 'package:e_commerce/domain/use_cases/register_use_case.dart';
import 'package:e_commerce/features/auth/cubit/register/register_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit({required this.registerUseCase})
    : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController phone = TextEditingController();

  register() async {
    if(formKey.currentState?.validate() == false) return;
    emit(RegisterLoadingState());
    final double? phoneNumber = double.tryParse(phone.text.trim());

    var result = await registerUseCase.call(
      name: name.text.trim(),
      email: email.text.trim(),
      password: password.text.trim(),
      phone: phoneNumber ?? 0,
    );
    result.fold(
      (error) => emit(RegisterErrorState(error: error)),
      (success) => emit(RegisterSuccessState(success: success)),
    );
  }
}
