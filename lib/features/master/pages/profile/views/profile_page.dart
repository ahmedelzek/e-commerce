import 'package:e_commerce/core/app_router/app_router_keys.dart';
import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:e_commerce/features/master/pages/profile/cubit/profile_cubit.dart';
import 'package:e_commerce/features/master/pages/profile/cubit/profile_state.dart';
import 'package:e_commerce/features/master/pages/profile/views/widgets/customized_card.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/injector.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr;
    return BlocProvider(
      create: (context) => sl<ProfileCubit>()..getUserData(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
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
            body: Builder(
              builder: (context) {
                if (state is ProfileLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColors.red),
                  );
                }

                if (state is ProfileErrorState) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Text(state.error),
                    ),
                  );
                }

                if (state is ProfileSuccessState) {
                  final user = state.user;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      children: [
                        Center(
                          child: ClipOval(
                            child:
                                user.imagePath == null
                                    ? Image.asset(
                                      AppImages.avatar,
                                      height: 96.h,
                                      width: 96.w,
                                    )
                                    : Image.network(
                                      user.imagePath ?? "",
                                      height: 96.h,
                                      width: 96.h,
                                    ),
                          ),
                        ),
                        SizedBox(height: 19.h),
                        Text(
                          user.name,
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
                          onTap: () async {
                           await context.push(
                              AppRouterKeys.updateProfile,
                              extra: state.user,
                            );
                           ProfileCubit.get(context).getUserData();
                          },
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
                          onPressed: () {
                            ProfileCubit.get(context).logout();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                const WidgetStatePropertyAll<Color>(
                                  AppColors.white,
                                ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                size: 24.r,
                                color: AppColors.black,
                              ),
                              SizedBox(width: 20.w),
                              Text(
                                tr.logout,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}
