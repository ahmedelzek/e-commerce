import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/app_colors.dart';

class CustomizedTabBar extends StatefulWidget {
  final Function(int index) onTap;


  const CustomizedTabBar({super.key, required this.onTap});

  @override
  State<CustomizedTabBar> createState() => _CustomizedTabBarState();
}

class _CustomizedTabBarState extends State<CustomizedTabBar> {
  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);

    return TabBar(
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
      ),      onTap: widget.onTap,
      tabs: [
        _tabItem(title: tr.active),
        _tabItem(title: tr.completed),
        _tabItem(title: tr.canceled),
      ],
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
          borderRadius: BorderRadius.circular(30.r)),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
      ),
    );
  }
}