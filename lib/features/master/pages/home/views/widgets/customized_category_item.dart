import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizedCategoryItem extends StatelessWidget {
  final String imagePath;
  final String name;

  const CustomizedCategoryItem({super.key, required this.imagePath, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.network(
            imagePath,
            width: 56.w,
            height: 56.h,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10.sp),
        ),
      ],
    );
  }
}
