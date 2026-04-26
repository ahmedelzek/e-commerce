import 'package:e_commerce/core/customized_widgets/customized_app_bar.dart';
import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:e_commerce/features/my_orders/views/widgets/cusomized_order_card.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int _selectedIndex = 0;

  final List<List<int>> _orderLists = [
    [1, 2, 3], // active
    [1],        // completed
    [1, 2],     // canceled
  ];

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomizedAppBar(title: tr.my_orders, context: context),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                    vertical: 10.h,
                  ),
                  child: TabBar(
                    labelPadding: EdgeInsets.symmetric(horizontal: 3.w),
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    unselectedLabelColor: AppColors.red,
                    labelColor: AppColors.white,
                    dividerHeight: 0,
                    indicatorColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    onTap: (index) {
                      setState(() => _selectedIndex = index);
                    },
                    tabs: [
                      _tabItem(title: tr.active),
                      _tabItem(title: tr.completed),
                      _tabItem(title: tr.canceled),
                    ],
                  ),
                ),
              ),
            ],
            body: Column(
              children: [
                Expanded(child: _buildOrderList(_orderLists[_selectedIndex])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabItem({required String title}) {
    return Tab(
      child: Container(
        height: 28.h,
        width: 108.w,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: AppColors.red),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildOrderList(List items) {
    if (items.isEmpty) {
      return const Center(child: Text('No orders found'));
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
      itemCount: items.length,
      itemBuilder: (context, index) => const CustomizedOrderCard(),
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
    );
  }
}