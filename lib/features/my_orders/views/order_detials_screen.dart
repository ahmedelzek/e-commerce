import 'package:e_commerce/core/customized_widgets/customized_app_bar.dart';
import 'package:e_commerce/core/customized_widgets/customized_button.dart';
import 'package:e_commerce/core/helpers/date_helper.dart';
import 'package:e_commerce/core/resources/app_assets.dart';
import 'package:e_commerce/core/resources/app_colors.dart';
import 'package:e_commerce/domain/entities/order/order_entity.dart';
import 'package:e_commerce/domain/entities/order/order_item_entity.dart';
import 'package:e_commerce/l10n/app_tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const double _tax = 3.00;
const double _deliveryFee = 2.00;

class OrderDetailsScreen extends StatelessWidget {
  final OrderEntity order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    final subtotal = order.total;
    final total = subtotal + _tax + _deliveryFee;

    return Scaffold(
      appBar: CustomizedAppBar(title: tr.order_details, context: context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${tr.order_number} ${order.id}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${extractDate(order.orderDate)} - ${extractTime(order.orderDate)}',
                      style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                    ),
                  ],
                ),
                Text(
                  _getStatusLabel(tr, order.status),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Divider(color: AppColors.grey.withValues(alpha: .3)),
            SizedBox(height: 10.h),
            ...order.items.map((item) => _buildOrderItem(item, tr)),
            SizedBox(height: 10.h),
            Divider(color: AppColors.grey.withValues(alpha: .3)),
            SizedBox(height: 12.h),
            _buildPriceRow(
              label: tr.subtotal,
              value: '\$ ${subtotal.toStringAsFixed(2)}',
            ),
            SizedBox(height: 8.h),
            _buildPriceRow(
              label: tr.tax,
              value: '\$ ${_tax.toStringAsFixed(2)}',
            ),
            SizedBox(height: 8.h),
            _buildPriceRow(
              label: tr.delivery_fee,
              value: '\$ ${_deliveryFee.toStringAsFixed(2)}',
            ),
            SizedBox(height: 12.h),
            Divider(color: AppColors.grey.withValues(alpha: .3)),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tr.total,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  '\$ ${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            _buildBottomSection(tr, order.status),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(OrderItemEntity item, dynamic tr) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                item.imagePath,
                width: 100.w,
                height: 100.h,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.asset(
                  AppImages.dummyImage,
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Text(
                        item.rating.toString(),
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      Icon(Icons.star, color: Colors.amber, size: 12.r),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    '${item.quantity} ${item.quantity == 1 ? tr.item : tr.items}',
                    style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Text(
                        '\$ ${item.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '\$ ${(item.price * 1.5).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${tr.total} (${item.quantity}) :',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
            ),
            Text(
              '\$ ${item.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Divider(color: AppColors.grey.withValues(alpha: .2)),
        SizedBox(height: 10.h),
      ],
    );
  }

  String _getStatusLabel(dynamic tr, int status) {
    if (status == 0) return tr.active;
    if (status == 1) return tr.completed;
    if (status == 2) return tr.canceled;
    return '';
  }

  Widget _buildPriceRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildBottomSection(dynamic tr, int status) {
    if (status == 1) {
      return _buildStatusBadge(label: tr.completed, color: Colors.green);
    }
    if (status == 2) {
      return _buildStatusBadge(label: tr.canceled, color: AppColors.red);
    }
    return Row(
      children: [
        Expanded(
          child: CustomizedButton(
            title: tr.cancel_order,
            onTap: () {},
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: CustomizedButton(
            title: tr.track_driver,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge({required String label, required Color color}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withValues(alpha: .4)),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}