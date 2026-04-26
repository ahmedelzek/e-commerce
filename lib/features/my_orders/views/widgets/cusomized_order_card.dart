import 'package:e_commerce/core/helpers/date_helper.dart';
import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:e_commerce/features/my_orders/views/widgets/card_button.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/entities/order/order_entity.dart';
import '../../../../domain/entities/order/order_item_entity.dart';

class CustomizedOrderCard extends StatelessWidget {
  final OrderEntity order;

  const CustomizedOrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    final firstItem = order.items.first;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: .15),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  firstItem.imagePath,
                  width: 70.w,
                  height: 70.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    AppImages.dummyImage,
                    width: 70.w,
                    height: 70.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          firstItem.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          '\$ ${order.total.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${extractDate(order.orderDate)} -  ${extractTime(order.orderDate)}",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.grey,
                          ),
                        ),
                        Text(
                          '${order.items.length} ${order.items.length == 1 ? tr.item : tr.items}',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),
          Container(color: AppColors.grey.withValues(alpha: .2), height: 1.h),
          SizedBox(height: 12.h),

          Row(
            children: [
              Expanded(child: CardButton(title: tr.canceled)),
              SizedBox(width: 10.w),
              Expanded(child: CardButton(title: tr.track_driver)),
            ],
          ),
        ],
      ),
    );
  }
}