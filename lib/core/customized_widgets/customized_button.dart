import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizedButton extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final double? horizontalMargin;
  final double? verticalMargin;
  final bool clickAble;
  final bool isSecondBtn;

  const CustomizedButton({
    super.key,
    required this.title,
    this.isSecondBtn = false,
    this.clickAble = true,
    this.onTap,
    this.horizontalMargin,
    this.verticalMargin,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55.h,
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          vertical: verticalMargin ?? 0,
          horizontal: horizontalMargin ?? 0,
        ),
        padding: EdgeInsets.symmetric(vertical: 13.5.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: !isSecondBtn ? AppColors.red : AppColors.white,
          border: isSecondBtn
              ? Border.all(color: AppColors.red, width: 2)
              : null,
        ),

        child: clickAble ? Text(
          title,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: !isSecondBtn?AppColors.white: AppColors.red,
          ),
        ):SizedBox(
          height: 24.h,
          width: 24.w,
          child: CircularProgressIndicator(color: AppColors.white),
        ),
      ),
    );
  }
}
