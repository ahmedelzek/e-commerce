import 'package:e_commerce/core/customized_widgets/customized_shimmer_effect.dart';
import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:e_commerce/features/master/pages/items/cubit/items_cubit.dart';
import 'package:e_commerce/features/master/pages/items/cubit/items_state.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_router/app_router_keys.dart';
import '../../../../../core/customized_widgets/customized_product_item.dart';
import '../../../../../core/di/injector.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../home/views/widgets/customized_category_item.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return BlocProvider(
      create: (_) => sl<ItemsCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(title: Image.asset(AppImages.appLogo)),
        body: BlocBuilder<ItemsCubit, ItemsState>(
          builder: (context, state) {
            if (state is ItemsLoadingState) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: CustomizedShimmerEffect());
            }

            if (state is ItemsErrorState) {
              return Center(child: Text(state.error));
            }

            if (state is ItemsSuccessState) {
              final cubit = ItemsCubit.get(context);

              return Padding(
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
                      height: 90.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          return GestureDetector(
                            onTap: () => cubit.selectCategory(index),
                            child: CustomizedCategoryItem(
                              name: category.title,
                              imagePath: category.imagePath,
                              isSelected: cubit.selectedCategoryIndex == index,
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => SizedBox(width: 15.w),
                      ),
                    ),

                    SizedBox(height: 32.h),
                    Text(
                      tr.product,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    Expanded(
                      child:
                          state.products.isEmpty
                              ? Center(
                                child: Image.asset(
                                  AppImages.emptyOrder,
                                  width: 200.w,
                                  height: 200.h,
                                ),
                              )
                              : GridView.builder(
                                itemCount: state.products.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 16.w,
                                      mainAxisSpacing: 12.h,
                                      mainAxisExtent: 310.h,
                                    ),
                                itemBuilder: (context, index) {
                                  final product = state.products[index];
                                  return CustomizedProductItem(
                                    productName: product.name,
                                    description: product.description,
                                    imagePath: product.imagePath,
                                    price: product.price,
                                    rate: product.rating,
                                    reviewCount: product.price,
                                    onTap:
                                        () => context.push(
                                          AppRouterKeys.product,
                                          extra: product,
                                        ),
                                  );
                                },
                              ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
