import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizedProductItem extends StatelessWidget {
  final String productName;
  final String description;
  final String imagePath;
  final double price;
  final double reviewCount;
  final double rate;
  final Function()? onTap;

  const CustomizedProductItem({
    super.key,
    required this.productName,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.rate,
    required this.reviewCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);

    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imagePath, width: double.infinity, height: 195.h),
            SizedBox(height: 8.h),
            Text(
              productName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              description,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "\$ $price",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 4.h),
            _buildStarRating(rating: rate, reviewCount: reviewCount),
          ],
        ),
      ),
    );
  }

  Widget _buildStarRating({
    required double rating,
    required double reviewCount,
  }) {
    return Row(
      children: [
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
          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
