import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_router/app_router_keys.dart';
import '../../../core/customized_widgets/customized_app_bar.dart';
import '../../../core/customized_widgets/customized_product_item.dart';
import '../../../core/di/injector.dart';
import '../../../core/resources/app_colors.dart';
import '../../../l10n/app_tr.dart';
import '../../master/pages/home/cubit/home_cubit.dart';
import '../../master/pages/home/cubit/home_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);

    return BlocProvider(
      create: (context)=>sl<HomeCubit>()..getData(),
      child: Scaffold(
        appBar: CustomizedAppBar(title: tr.my_favorites, context: context),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final cubit = HomeCubit.get(context);
            final favorites = cubit.favoriteProducts;
            if(state is HomeLoadingState){
              return Center(child: CircularProgressIndicator(color: AppColors.red,),);
            }

            return GridView.builder(
              itemCount: favorites.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 12.h,
                mainAxisExtent: 310.h,
              ),
              itemBuilder: (context, index) {
                final product = favorites[index];

                return CustomizedProductItem(
                  productName: product.name,
                  description: product.description,
                  imagePath: product.imagePath,
                  price: product.price,
                  rate: product.rating,
                  reviewCount: product.rating,
                  onTap: () => context.push(
                    AppRouterKeys.product,
                    extra: product,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}