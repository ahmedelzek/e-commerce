import 'package:e_commerce/core/app_router/app_router_keys.dart';
import 'package:e_commerce/core/customized_widgets/customized_app_bar.dart';
import 'package:e_commerce/core/customized_widgets/customized_button.dart';
import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:e_commerce/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce/features/cart/cubit/cart_state.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/customized_widgets/customized_cart_item.dart';

const double _tax = 3.00;
const double _deliveryFee = 2.00;

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return Scaffold(
      appBar: CustomizedAppBar(title: tr.cart, context: context),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cubit = CartCubit.get(context);
          final items = cubit.items;
          final subtotal = cubit.subtotal;
          final total = subtotal + _tax + _deliveryFee;

          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      AppImages.emptyOrder, width: 100.w, height: 100.h, ),
                  SizedBox(height: 16.h),
                  Text(
                    tr.cart_empty,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.pink,
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                Text(
                  tr.shopping_list,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),

                // Cart Items List
                Expanded(
                  child: ListView.separated(
                    itemCount: items.length,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    itemBuilder: (context, index) {
                      final cartItem = items[index];
                      return CustomizedCartItem(
                        cartItem: cartItem,
                        onIncrement: () =>
                            cubit.updateQuantity(
                              cartItem.product.id,
                              cartItem.quantity + 1,
                            ),
                        onDecrement: () =>
                            cubit.updateQuantity(
                              cartItem.product.id,
                              cartItem.quantity - 1,
                            ),
                        onRemove: () =>
                            cubit.removeFromCart(cartItem.product.id),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10.h),
                  ),
                ),

                SizedBox(height: 30.h),

                // Divider
                Container(
                  height: 1.h,
                  width: double.infinity,
                  color: AppColors.grey,
                ),

                SizedBox(height: 12.h),

                _buildPriceRow(
                  label: tr.subtotal,
                  value: '\$ ${subtotal.toStringAsFixed(2)}',
                ),

                SizedBox(height: 12.h),

                _buildPriceRow(
                  label: tr.tax,
                  value: '\$ ${_tax.toStringAsFixed(2)}',
                ),

                SizedBox(height: 12.h),

                _buildPriceRow(
                  label: tr.delivery_fee,
                  value: '\$ ${_deliveryFee.toStringAsFixed(2)}',
                ),

                SizedBox(height: 12.h),

                Container(
                  height: 1.h,
                  width: double.infinity,
                  color: AppColors.grey,
                ),

                SizedBox(height: 12.h),

                Row(
                  children: [
                    Text(
                      tr.total,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17.sp,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$ ${total.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: AppColors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 35.h),
                CustomizedButton(title: tr.checkout, onTap: ()=>context.push(AppRouterKeys.checkout)),
                SizedBox(height: 15.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPriceRow({required String label, required String value}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
        ),
      ],
    );
  }
}