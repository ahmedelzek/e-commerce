import 'package:dartz/dartz.dart';

import '../entities/order/order_requast_entity.dart';
import '../entities/order/orders_entity.dart';
import '../entities/order/place_order_response_entity.dart';

abstract class OrderRepo {
  Future<Either<String, PlaceOrderResponseEntity>> placeOrder(List<OrderItemRequestEntity> items);
  Future<Either<String, PlaceOrderResponseEntity>> cancelOrder(int orderId);
  Future<Either<String, PlaceOrderResponseEntity>> completeOrder(int orderId);
  Future<Either<String, OrdersEntity>> getOrders();
}