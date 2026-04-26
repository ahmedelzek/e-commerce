import 'package:e_commerce/domain/entities/order/order_item_entity.dart';
import 'package:e_commerce/domain/entities/product/product_entity.dart';

class OrdersEntity {
  final List<OrderItemEntity> active;
  final List<OrderItemEntity> canceled;
  final List<OrderItemEntity> completed;

  const OrdersEntity({
    required this.active,
    required this.canceled,
    required this.completed,
  });
}