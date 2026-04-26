import 'package:e_commerce/core/customized_widgets/customized_app_bar.dart';
import 'package:e_commerce/core/customized_widgets/customized_app_snack_bar.dart';
import 'package:e_commerce/core/customized_widgets/customized_button.dart';
import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:e_commerce/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce/features/product/cubit/favorite_cubit.dart';
import 'package:e_commerce/features/product/cubit/favorite_state.dart';
import 'package:e_commerce/features/product/views/widgets/quantity_selector.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/di/injector.dart';
import '../../../domain/entities/product/product_entity.dart';

class ProductScreen extends StatefulWidget {
  final ProductEntity product;

  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int _quantity = 1;

  void _increment() {
    if (_quantity < 10) setState(() => _quantity++);
  }

  void _decrement() {
    if (_quantity > 1) setState(() => _quantity--);
  }

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return BlocProvider(
      create: (context)=>sl<FavoriteCubit>(),
      child: Scaffold(
        appBar: CustomizedAppBar(title: tr.product, context: context),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Image.network(
                  widget.product.imagePath,
                  height: 308.h,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 35.h),
              Row(
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  BlocConsumer<FavoriteCubit, FavoriteState>(
                    listener: (context, state){
                      if(state is FavoriteSuccessState){
                        AppSnackBar.showSuccess(context, state.success);
                      }
                      if(state is FavoriteErrorState){
                        AppSnackBar.showSuccess(context, state.error);
                      }
                    },
                    builder: (context, state) {
                      final cubit = FavoriteCubit.get(context);
                      return IconButton(
                        onPressed: ()=>cubit.addToFavorite(widget.product.id),
                        icon:
                            widget.product.isFavorite
                                ? Icon(Icons.favorite, color: AppColors.red)
                                : Icon(Icons.favorite_border, color: AppColors.pink),
                      );
                    }
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              Text(
                widget.product.description,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 32.h),
              Row(
                children: [
                  Text(
                    "${widget.product.price}-${tr.eg}",
                    style: TextStyle(
                      color: AppColors.red,
                      fontWeight: FontWeight.w400,
                      fontSize: 20.sp,
                    ),
                  ),
                  const Spacer(),
                  QuantitySelector(
                    value: _quantity,
                    onIncrement: _increment,
                    onDecrement: _decrement,
                  ),
                ],
              ),
              SizedBox(height: 55.h),
              CustomizedButton(
                title: tr.add_to_cart,
                onTap: () {
                  context.read<CartCubit>().addToCart(widget.product, _quantity);
                  AppSnackBar.showSuccess(
                    context,
                    '${widget.product.name} ${tr.added_to_cart}',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
