import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/entities/order/oder_response_entity.dart';
import 'package:e_commerce/domain/entities/order/place_order_response_entity.dart';

import '../entities/order/order_item_entity.dart';

abstract class OrderRepo {
  Future<Either<String, PlaceOrderResponseEntity>> placeOrder(
    List<OrderItemEntity> items,
  );

  Future<Either<String, PlaceOrderResponseEntity>> cancelOrder(int orderId);

  Future<Either<String, PlaceOrderResponseEntity>> completeOrder(int orderId);

  Future<Either<String, OrdersResponseEntity>> getOrders();
}
