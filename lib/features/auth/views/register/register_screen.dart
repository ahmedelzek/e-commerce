import 'package:e_commerce/core/app_router/app_router_keys.dart';
import 'package:e_commerce/core/customized_widgets/customized_app_snack_bar.dart';
import 'package:e_commerce/core/customized_widgets/customized_button.dart';
import 'package:e_commerce/core/customized_widgets/customized_text_field.dart';
import 'package:e_commerce/core/helpers/validator_helper.dart';
import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:e_commerce/features/auth/cubit/register/register_cubit.dart';
import 'package:e_commerce/features/auth/cubit/register/register_state.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injector.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr;
    return BlocProvider(
      create: (context) => sl<RegisterCubit>(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            AppSnackBar.showSuccess(context, state.success);
            context.go(AppRouterKeys.loginKey);
          } else if (state is RegisterErrorState) {
            AppSnackBar.showError(context, state.error);
          }
        },
        builder: (context, state) {
          final cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: Container(
                margin: EdgeInsets.symmetric(horizontal: 30.w),
                child: InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr.create_account,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34.sp,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 45.h),
                      CustomizedTextField(
                        hintText: tr.name,
                        controller: cubit.name,
                        prefixIcon: AppIcons.profileIcon,
                        validator: Validators.requiredField,
                      ),
                      SizedBox(height: 22.h),
                      CustomizedTextField(
                        hintText: tr.phone,
                        controller: cubit.phone,
                        prefixIcon: AppIcons.phoneIcon,
                        validator: Validators.requiredField,
                        isPhone: true,
                      ),
                      SizedBox(height: 22.h),
                      CustomizedTextField(
                        hintText: tr.email,
                        controller: cubit.email,
                        prefixIcon: AppIcons.emailIcon,
                        validator: Validators.email,
                      ),
                      SizedBox(height: 22.h),
                      CustomizedTextField(
                        hintText: tr.password,
                        controller: cubit.password,
                        prefixIcon: AppIcons.passwordIcon,
                        validator: Validators.password,
                        isPassword: true,
                      ),
                      SizedBox(height: 22.h),
                      CustomizedTextField(
                        hintText: tr.confirm,
                        controller: cubit.confirmPassword,
                        prefixIcon: AppIcons.passwordIcon,
                        validator: (value) {
                          return Validators.confirmPassword(
                            value,
                            cubit.password.text.trim(),
                          );
                        },
                        isPassword: true,
                      ),
                      SizedBox(height: 22.h),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.grey,
                          ),
                          children: [
                            TextSpan(text: tr.register_prompt_part1),
                            TextSpan(
                              text: tr.register,
                              style: TextStyle(color: AppColors.red),
                            ),
                            TextSpan(text: tr.register_prompt_part2),
                          ],
                        ),
                      ),
                      SizedBox(height: 28.h),
                      CustomizedButton(
                        title: tr.register,
                        onTap: () => cubit.register(),
                        clickAble: state is! RegisterLoadingState,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
