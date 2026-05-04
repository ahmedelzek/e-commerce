import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../l10n/app_tr.dart';
import 'onboarding_model.dart';

class CustomPageView extends StatelessWidget {
  final PageController controller;
  final int pageCount;
  final int currentPage;
  final List<OnBoardingModel> pages;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onSkip;
  final bool isLastPage;
  final bool isFirstPage;

  const CustomPageView({
    super.key,
    required this.controller,
    required this.pageCount,
    required this.pages,
    required this.currentPage,
    required this.onPageChanged,
    required this.onNext,
    required this.onPrevious,
    required this.onSkip,
    required this.isLastPage,
    required this.isFirstPage,
  });

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return Padding(
      padding: EdgeInsets.all(15.sp),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              if (!isLastPage)
                GestureDetector(
                  onTap: onSkip,
                  child: Text(
                    tr.skip,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),

          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: pageCount,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                final page = pages[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(page.image),
                    SizedBox(height: 32.h),
                    Text(
                      page.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 24.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      page.desc,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),

          Row(
            children: [
              GestureDetector(
                onTap: isFirstPage ? null : onPrevious,
                child: Text(
                  tr.prev,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isFirstPage ? Colors.transparent : AppColors.grey,
                  ),
                ),
              ),
              const Spacer(),
              SmoothPageIndicator(
                controller: controller,
                count: pageCount,
                effect: ExpandingDotsEffect(
                  activeDotColor: AppColors.red,
                  dotColor: AppColors.grey,
                  dotWidth: 8.w,
                  dotHeight: 8.h,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onNext,
                child: Text(
                  isLastPage ? tr.get_started : tr.next,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.red,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}