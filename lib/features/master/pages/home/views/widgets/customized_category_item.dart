import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizedCategoryItem extends StatelessWidget {
  const CustomizedCategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(AppImages.categoryImage, width: 56.w, height: 56.h),
        ),
        SizedBox(height: 4.h),
        Text(
          "Fashion",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10.sp),
        ),
      ],
    );
  }
}
