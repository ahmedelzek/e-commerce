import 'dart:io';

import 'package:e_commerce/core/customized_widgets/customized_app_bar.dart';
import 'package:e_commerce/core/customized_widgets/customized_app_snack_bar.dart';
import 'package:e_commerce/core/customized_widgets/customized_button.dart';
import 'package:e_commerce/core/customized_widgets/customized_text_field.dart';
import 'package:e_commerce/core/customized_widgets/image_picker.dart';
import 'package:e_commerce/core/helpers/validator_helper.dart';
import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:e_commerce/domain/entities/user/user_entity.dart';
import 'package:e_commerce/features/my_profile/cubit/update_profile_cubit.dart';
import 'package:e_commerce/features/my_profile/cubit/update_profile_state.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injector.dart';

class UpdateProfileScreen extends StatelessWidget {
  final UserEntity user;

  const UpdateProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return BlocProvider(
      create: (context) => sl<UpdateProfileCubit>(),
      child: Scaffold(
        appBar: CustomizedAppBar(title: tr.profile, context: context),
        body: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
          listener: (context, state) {
            if (state is UpdateProfileSuccessState) {
              AppSnackBar.showSuccess(context, state.success);
              context.pop();
            }
            if (state is UpdateProfileErrorState) {
              AppSnackBar.showError(context, state.error);
            }
          },
          builder: (context, state) {
            final cubit = UpdateProfileCubit.get(context);
            cubit.name.text = user.name;
            cubit.phone.text = user.phone;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      ClipOval(
                        child: ImageManager(
                          unselectedImageBuilder: Image.asset(
                            AppImages.avatar,
                            width: 96.w,
                            height: 96.h,
                          ),
                          networkImageBuilder:
                              user.imagePath == null
                                  ? null
                                  : Image.network(
                                    user.imagePath!,
                                    height: 96.h,
                                    width: 96.w,
                                    fit: BoxFit.cover,
                                  ),
                          onImageSelected: (path) => cubit.imagePath = path,
                          selectedImageBuilder: (String imagePath) {
                            return SizedBox(
                              height: 96.h,
                              width: 96.w,
                              child: Image.file(
                                File(imagePath),
                                fit: BoxFit.contain,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 50.h),
                      CustomizedTextField(
                        hintText: tr.name,
                        prefixIcon: AppIcons.profileIcon,
                        controller: cubit.name,
                        validator: Validators.requiredField,
                      ),
                      SizedBox(height: 10.h),
                      CustomizedTextField(
                        hintText: tr.phone,
                        prefixIcon: AppIcons.phoneIcon,
                        controller: cubit.phone,
                        validator: Validators.requiredField,
                      ),
                      SizedBox(height: 75.h),
                      CustomizedButton(
                        title: tr.save,
                        onTap: () => cubit.updateProfile(),
                        clickAble: state is! UpdateProfileLoadingState,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
