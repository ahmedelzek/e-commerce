import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:e_commerce/features/my_orders/views/widgets/card_button.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizedOrderCard extends StatelessWidget {
  const CustomizedOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(9.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: .25),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  AppImages.dummyImage, // dummy image
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product Name",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Row(
                      children: [
                        Text(
                          "4.5",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.star, color: Colors.amber, size: 12.sp),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    Text(
                      '\$ 120.00',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Text(
                      '${tr.quantity}: 2',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Container(color: AppColors.grey, height: 1.h, width: double.infinity),

          SizedBox(height: 12.h),

          Row(
            children: [
              Expanded(child: CardButton(title: tr.completed)),
              const Spacer(),
              Expanded(child: CardButton(title: tr.canceled)),
            ],
          ),
        ],
      ),
    );
  }
}
