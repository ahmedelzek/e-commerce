import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../resources/app_colors.dart';

AppBar CustomizedAppBar({required String title, required BuildContext context}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: AppColors.black,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
    leading: Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      child: InkWell(
        onTap: () {
          context.pop();
        },
        child: Icon(Icons.arrow_back_ios),
      ),
    ),
  );
}
