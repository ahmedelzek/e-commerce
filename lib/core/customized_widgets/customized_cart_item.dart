import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:e_commerce/features/product/views/widgets/quantity_selector.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/cart/cart.dart';

class CustomizedCartItem extends StatelessWidget {
  final CartItemEntity cartItem;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CustomizedCartItem({
    super.key,
    required this.cartItem,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr;
    final product = cartItem.product;
    final totalPrice = product.price * cartItem.quantity;

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
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  product.imagePath,
                  width: 125.h,
                  height: 125.w,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Text(
                          product.rating.toString(),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.star, color: Colors.amber, size: 12.sp),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      '\$ ${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        QuantitySelector(
                          value: cartItem.quantity,
                          onIncrement: onIncrement,
                          onDecrement: cartItem.quantity <= 1
                              ? onRemove
                              : onDecrement,
                        ),
                      ],
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
              Text(
                '${tr.total} (${cartItem.quantity}): ',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Text(
                '\$ ${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}