import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomizedCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final Function()? onTap;

  const CustomizedCard({
    super.key,
    required this.iconPath,
    required this.title,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(18.sp),
            child: SvgPicture.asset(iconPath),
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, size: 18.r),
        ],
      ),
    );
  }
}
