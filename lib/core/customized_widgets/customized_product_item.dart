import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizedProductItem extends StatelessWidget {
  const CustomizedProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppImages.dummyImage, width: double.infinity, height: 195.h),
          SizedBox(height: 8.h),
          Text(
            "Product Name",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "Mens Starry Sky Printed Shirt 100% Cotton Fabric",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 10.sp,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "₹399",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 4.h),
          _buildStarRating(rating: 3.5, reviewCount: 1343434)
        ],
      ),
    );
  }
  Widget _buildStarRating({required double rating, required int reviewCount}) {
    return Row(
      children: [
        // Stars
        Row(
          children: List.generate(5, (index) {
            if (index < rating.floor()) {
              return Icon(Icons.star, color: Colors.amber, size: 14.sp);
            } else if (index < rating && rating - index >= 0.5) {
              return Icon(Icons.star_half, color: Colors.amber, size: 14.sp);
            } else {
              return Icon(Icons.star_border, color: Colors.amber, size: 14.sp);
            }
          }),
        ),
        SizedBox(width: 4.w),
        Text(
          "($reviewCount)",
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
