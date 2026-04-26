
import 'order_entity.dart';

class OrdersEntity {
  final List<OrderEntity> active;
  final List<OrderEntity> canceled;
  final List<OrderEntity> completed;

  const OrdersEntity({
    required this.active,
    required this.canceled,
    required this.completed,
  });
}