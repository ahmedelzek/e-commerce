import 'package:e_commerce/core/app_router/app_router_keys.dart';
import 'package:e_commerce/core/customized_widgets/customized_app_bar.dart';
import 'package:e_commerce/core/customized_widgets/customized_shimmer_effect.dart';
import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:e_commerce/features/my_orders/views/widgets/cusomized_order_card.dart';
import 'package:e_commerce/features/my_orders/views/widgets/customized_tab_bar.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injector.dart';
import '../../../domain/entities/order/order_entity.dart';
import '../cubit/my_orders_cubit.dart';
import '../cubit/my_orders_state.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    final tabs = [tr.active, tr.completed, tr.canceled];

    return BlocProvider(
      create: (context) => sl<OrdersCubit>()..getOrders(),
      child: Scaffold(
        appBar: CustomizedAppBar(title: tr.my_orders, context: context),
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoadingState) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: CustomizedShimmerEffect(),
              );
            }

            if (state is OrdersErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.error),
                    SizedBox(height: 12.h),
                    ElevatedButton(
                      onPressed: () => OrdersCubit.get(context).getOrders(),
                      child:  Text(tr.retry),
                    ),
                  ],
                ),
              );
            }

            if (state is OrdersSuccessState) {
              final currentList = [
                state.orders.active,
                state.orders.completed,
                state.orders.canceled,
              ][_selectedIndex];

              return Column(
                children: [
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 40.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      itemCount: tabs.length,
                      itemBuilder: (context, index) {
                        return CustomTabBar(
                          text: tabs[index],
                          isSelected: _selectedIndex == index,
                          onPressed: () => setState(() => _selectedIndex = index),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Expanded(child: _buildOrderList(currentList, context)),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildOrderList(List<OrderEntity> orders, BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.emptyOrder, width: 200.w, height: 200.w,),
            Text(
              LocalizationService.instance.tr(context).no_orders_found,
              style: TextStyle(fontSize: 20.sp, color: AppColors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
      itemCount: orders.length,
      itemBuilder: (context, index) => InkWell(
        onTap: (){
          context.push(AppRouterKeys.orderDetails, extra: orders[index]);
        },
        child: CustomizedOrderCard(
          order: orders[index],
          onCancel: () => OrdersCubit.get(context).cancelOrder(orders[index].id),
          onComplete: () => OrdersCubit.get(context).completeOrder(orders[index].id),
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
    );
  }
}