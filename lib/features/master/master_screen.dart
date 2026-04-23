import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:e_commerce/features/master/widgets/bottom_nav_bar_icons.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  int selectedIndex = 0;

  void changeTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr;
    return Scaffold(
      body: taps[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.red,
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        currentIndex: selectedIndex,
        onTap: changeTab,
        items: generateBottomNavItems({
          AppIcons.homeIcon: tr.home,
          AppIcons.cartIcon: tr.cart,
          AppIcons.profileIcon2: tr.profile,
        }),
      ),
    );
  }
}
