import 'package:e_commerce/core/customized_widgets/customized_app_bar.dart';
import 'package:e_commerce/core/customized_widgets/customized_button.dart';
import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:e_commerce/features/product/views/widgets/quantity_selector.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/product/product_entity.dart';

class ProductScreen extends StatelessWidget {
  final ProductEntity product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr;
    return Scaffold(
      appBar: CustomizedAppBar(title: tr.product, context: context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: Image.network(
                product.imagePath,
                height: 308.h,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 35.h),
            Text(
              product.name,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              product.description,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 32.h),
            Row(
              children: [
                Text(
                  "${product.price}-${tr.eg}",
                  style: TextStyle(
                    color: AppColors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 20.sp,
                  ),
                ),
                Spacer(),
                QuantitySelector(),
              ],
            ),
            SizedBox(height: 55.h),
            CustomizedButton(title: tr.add_to_cart),
          ],
        ),
      ),
    );
  }
}
