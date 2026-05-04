import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CustomizedShimmerEffect extends StatelessWidget {
  const CustomizedShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      interval: Duration(seconds: 5),
      child: Column(
        children: [
          SizedBox(height: 60.h,),
          Expanded(
            child: ListView.separated(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 190.h,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(16.sp)
                  ),
                );
              },
              separatorBuilder: (_,__)=> SizedBox(height: 15.h)
            ),
          ),
        ],
      ),
    );
  }
}
