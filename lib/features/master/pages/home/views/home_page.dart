import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/core/customized_widgets/customized_button.dart';
import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:e_commerce/features/master/pages/home/cubit/home_cubit.dart';
import 'package:e_commerce/features/master/pages/home/cubit/home_state.dart';
import 'package:e_commerce/features/master/pages/home/views/widgets/customized_category_item.dart';
import 'package:e_commerce/features/master/pages/home/views/widgets/customized_slides_items.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/customized_widgets/customized_product_item.dart';
import '../../../../../core/di/injector.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr;
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..getData(),
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(AppImages.appLogo, width: 110.w, height: 32.h),
        ),
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final cubit = HomeCubit.get(context);

              if (state is HomeLoadingState) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.red),
                );
              }

              if (state is HomeErrorState) {
                return Center(
                  child: Column(
                    children: [
                      Text(state.error),
                      CustomizedButton(
                        title: tr.retry,
                        horizontalMargin: 50.w,
                        onTap: () => cubit.getData(),
                      ),
                    ],
                  ),
                );
              }

              if (state is HomeSuccessState) {
                final sliders = cubit.sliders ?? [];
                final products = cubit.products ?? [];
                final categories = cubit.categories ?? [];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 28.h),
                      InkWell(
                        onTap: () {
                          print(categories.length);
                        },
                        child: Text(
                          tr.all_featured,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      SizedBox(
                        height: 80.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder:
                              (context, index) => CustomizedCategoryItem(
                                key: ValueKey(categories[index].id),
                                name: categories[index].title,
                                imagePath: categories[index].imagePath,
                              ),
                          separatorBuilder: (_, __) => SizedBox(width: 15.w),
                        ),
                      ),
                      SizedBox(height: 39.h),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 190.h,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration: const Duration(
                            milliseconds: 700,
                          ),
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          onPageChanged:
                              (index, reason) => cubit.updateIndex(index),
                        ),
                        items:
                            sliders.map((slider) {
                              return CustomizedSlidesItems(
                                title: slider.title ?? "",
                                description: slider.description ?? "",
                                imagePath: slider.imagePath,
                              );
                            }).toList(),
                      ),
                      SizedBox(height: 12.h),
                      Center(
                        child: AnimatedSmoothIndicator(
                          // ← replace SmoothPageIndicator
                          activeIndex: cubit.currentIndex,
                          count: sliders.length,
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
                          itemCount: products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16.w,
                                mainAxisSpacing: 12.h,
                                mainAxisExtent: 310.h,
                              ),
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return CustomizedProductItem(
                              productName: product.name,
                              description: product.description,
                              imagePath: product.imagePath,
                              price: product.price,
                              rate: product.rating,
                              reviewCount: product.price,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
