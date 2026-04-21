import 'package:e_commerce/core/customized_widgets/customized_button.dart';
import 'package:e_commerce/core/customized_widgets/customized_text_field.dart';
import 'package:e_commerce/core/helpers/validator_helper.dart';
import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr;
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr.welcome,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 34.sp,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 45.h),
            CustomizedTextField(
              hintText: tr.email,
              prefixIcon: AppIcons.emailIcon,
              validator: Validators.email,
            ),
            SizedBox(height: 22.h),
            CustomizedTextField(
              hintText: tr.password,
              prefixIcon: AppIcons.passwordIcon,
              validator: Validators.password,
              isPassword: true,
            ),
            SizedBox(height: 56.h),
            CustomizedButton(title: tr.login),
          ],
        ),
      ),
    );
  }
}
