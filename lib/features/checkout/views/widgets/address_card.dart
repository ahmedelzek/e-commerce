import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr.address,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10.h),
              Text(
                tr.address_prompt,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        Container(
          height: 78.h,
          width: 78.w,
          decoration: BoxDecoration(
            color: AppColors.red,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.location_on_outlined,
            size: 40.r,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
