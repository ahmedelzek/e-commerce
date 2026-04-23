import 'package:e_commerce/features/master/pages/cart/views/cart_page.dart';
import 'package:e_commerce/features/master/pages/home/views/home_page.dart';
import 'package:e_commerce/features/master/pages/profile/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/resources/app_colors.dart';

List<BottomNavigationBarItem> generateBottomNavItems(
  Map<String, String> iconMap,
) {
  return iconMap.entries
      .map(
        (entry) => BottomNavigationBarItem(
          icon: SvgPicture.asset(
            entry.key,
            colorFilter: ColorFilter.mode(
              AppColors.black, // Your desired color
              BlendMode.srcIn,
            ),
          ),
          activeIcon: SvgPicture.asset(
              entry.key,
              colorFilter: ColorFilter.mode(AppColors.red, BlendMode.srcIn),
            ),
          backgroundColor: AppColors.white,
          label: entry.value,
        ),
      )
      .toList();
}

List<Widget> taps = [
  const HomePage(),
  const CartPage(),
  const ProfilePage(),
];
