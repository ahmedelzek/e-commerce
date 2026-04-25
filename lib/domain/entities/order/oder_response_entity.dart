import 'order_entity.dart';

class OrdersResponseEntity {
  final bool status;
  final OrdersEntity orders;

  const OrdersResponseEntity({
    required this.status,
    required this.orders,
  });
}