import 'package:e_commerce/domain/use_cases/login_use_case.dart';
import 'package:e_commerce/features/auth/cubit/login/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  login() async {
    if (formKey.currentState?.validate() == false) return;
    emit(LoginLoadingState());
    var result = await loginUseCase.call(
      email: email.text.trim(),
      password: password.text.trim(),
    );
    result.fold(
      (error) => emit(LoginErrorState(error: error)),
      (userEntity) => emit(LoginSuccessState(user: userEntity)),
    );
  }
}
