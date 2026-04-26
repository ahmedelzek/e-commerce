import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizedCategoryItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final bool isSelected;

  const CustomizedCategoryItem({
    super.key,
    required this.imagePath,
    required this.name,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(2.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? AppColors.red : Colors.transparent,
              width: 2.r,
            ),
          ),
          child: ClipOval(
            child: Image.network(
              imagePath,
              width: 56.w,
              height: 56.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10.sp,
            color: isSelected ? AppColors.red : AppColors.black,
          ),
        ),
      ],
    );
  }
}