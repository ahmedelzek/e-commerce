import 'driver_entity.dart';
import 'order_item_entity.dart';

class OrderEntity {
  final int id;
  final int status;
  final String orderDate;
  final String? orderChangeDate;
  final double subtotal;
  final double shipping;
  final double tax;
  final double total;
  final DriverEntity? driver;
  final List<OrderItemEntity> items;

  const OrderEntity({
    required this.id,
    required this.status,
    required this.orderDate,
    this.orderChangeDate,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.total,
    this.driver,
    required this.items,
  });
}