import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:e_commerce/features/master/pages/profile/views/widgets/customized_card.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr.profile,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            Center(
              child: ClipOval(
                child: Image.asset(AppImages.avatar, height: 96.h, width: 96.w),
              ),
            ),
            SizedBox(height: 19.h),
            Text(
              "User Name",
              style: TextStyle(
                color: AppColors.red,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 50.h),
            CustomizedCard(
              iconPath: AppIcons.profileIcon2,
              title: tr.my_profile,
            ),
            SizedBox(height: 25.h),
            CustomizedCard(
              iconPath: AppIcons.bagIcon,
              title: tr.my_orders,
            ),
            SizedBox(height: 25.h),
            CustomizedCard(
              iconPath: AppIcons.favoriteIcon,
              title: tr.my_favorites,
            ),
            SizedBox(height: 25.h),
            CustomizedCard(
              iconPath: AppIcons.settingsIcon,
              title: tr.settings,
            ),
            SizedBox(height: 50.h),
            Container(
              width: double.infinity,
              height: 1.h,
              color: AppColors.red,
            ),
            SizedBox(height: 40.h),
            FilledButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll<Color>(AppColors.white),
              ),
              child: Row(
                children: [
                  Icon(Icons.logout, size: 24.r, color: AppColors.black,),
                  SizedBox(width: 20.w,),
                  Text(
                    tr.logout,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: AppColors.black
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
