import 'package:e_commerce/core/app_router/app_router_keys.dart';
import 'package:e_commerce/core/customized_widgets/customized_app_bar.dart';
import 'package:e_commerce/core/customized_widgets/customized_app_snack_bar.dart';
import 'package:e_commerce/core/customized_widgets/customized_button.dart';
import 'package:e_commerce/core/customized_widgets/customized_cart_item.dart';
import 'package:e_commerce/domain/entities/order/order_requast_entity.dart';
import 'package:e_commerce/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce/features/checkout/cubit/checkout_cubit.dart';
import 'package:e_commerce/features/checkout/cubit/checkout_state.dart';
import 'package:e_commerce/features/checkout/views/widgets/address_card.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injector.dart';
import '../../../domain/entities/order/order_item_entity.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);

    final cartCubit = CartCubit.get(context);
    final items = cartCubit.items;

    return BlocProvider(
      create: (context)=>sl<CheckoutCubit>(),
      child: Scaffold(
        appBar: CustomizedAppBar(title: tr.checkout, context: context),
        body: BlocListener<CheckoutCubit, CheckoutState>(
          listener: (context, state) {
            if (state is CheckoutSuccessState) {
              AppSnackBar.showSuccess(context, state.success);
              context.go(AppRouterKeys.master);
            } else if (state is CheckoutErrorState) {
              AppSnackBar.showError(context, state.error);
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddressCard(),
                SizedBox(height: 15.h),
                Text(
                  tr.shopping_list,
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10.h),

                // Cart items list from CartCubit
                Expanded(
                  child: ListView.separated(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final cartItem = items[index];
                      return CustomizedCartItem(
                        cartItem: cartItem,
                        showQuantitySelector: false,
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  ),
                ),

                SizedBox(height: 15.h),

                BlocBuilder<CheckoutCubit, CheckoutState>(
                  builder: (context, state) {
                    final isLoading = state is CheckoutLoadingState;
                    final items = CartCubit.get(context).items;
                    return CustomizedButton(
                      title: tr.checkout,
                      onTap:
                          () => CheckoutCubit.get(context).checkout(
                            items
                                .map(
                                  (cartItem) => OrderItemRequestEntity(
                                    productId: cartItem.product.id,
                                    quantity: cartItem.quantity,
                                  ),
                                )
                                .toList(),
                          ),
                      clickAble: !isLoading,
                    );
                  },
                ),

                SizedBox(height: 15.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
