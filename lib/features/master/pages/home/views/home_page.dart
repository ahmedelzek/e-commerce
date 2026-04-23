import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:e_commerce/features/master/pages/home/views/widgets/customized_category_item.dart';
import 'package:e_commerce/features/master/pages/home/views/widgets/customized_slides_items.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/customized_widgets/customized_product_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(AppImages.appLogo, width: 110.w, height: 32.h),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 28.h),
              Text(
                tr.all_featured,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 25.h),
              SizedBox(
                height: 80.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return CustomizedCategoryItem();
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 15.w);
                  },
                ),
              ),
              SizedBox(height: 39.h),
              SizedBox(
                height: 190.h,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 3,
                  itemBuilder: (context, state) {
                    return CustomizedSlidesItems();
                  },
                ),
              ),
              SizedBox(height: 12.h),
              Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: ScrollingDotsEffect(
                    activeDotColor: AppColors.red,
                    dotColor: AppColors.grey,
                    dotHeight: 9.h,
                    dotWidth: 9.w,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                tr.recommended,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: GridView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 12.h,
                    mainAxisExtent: 310.h
                  ),
                  itemBuilder: (context, index) {
                    return CustomizedProductItem();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
