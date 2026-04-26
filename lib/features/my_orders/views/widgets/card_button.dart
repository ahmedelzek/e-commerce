import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/app_colors.dart';

class CardButton extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final bool clickAble;

  const CardButton({
    super.key,
    required this.title,
    this.onTap,
    this.clickAble = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 22.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(8.sp),
        ),

        child:
            clickAble
                ? Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white
                  ),
                )
                : SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: CircularProgressIndicator(color: AppColors.white),
                ),
      ),
    );
  }
}
