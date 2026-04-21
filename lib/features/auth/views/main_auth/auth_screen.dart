import 'package:e_commerce/core/app_router/app_router_keys.dart';
import 'package:e_commerce/core/customized_widgets/customized_button.dart';
import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_tr.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.authImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              AppColors.black.withValues(alpha: 0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 38.w),
          child: Column(
            children: [
              SizedBox(height: 447.h),
              Text(
                tr.auth_prompt,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                tr.auth_text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightGrey,
                ),
              ),
              SizedBox(height: 24.h),
              CustomizedButton(
                title: tr.login,
                onTap: () => context.push(AppRouterKeys.loginKey),
              ),
              SizedBox(height: 15.h),
              CustomizedButton(
                title: tr.register,
                onTap: () => context.push(AppRouterKeys.registerKey),
                isSecondBtn: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
