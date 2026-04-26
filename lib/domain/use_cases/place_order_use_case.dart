import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/contract/order_repo.dart';
import 'package:e_commerce/domain/entities/order/place_order_response_entity.dart';

import '../entities/order/order_item_entity.dart';

class PlaceOrderUseCase {
  final OrderRepo repo;

  PlaceOrderUseCase({required this.repo});

  Future<Either<String, PlaceOrderResponseEntity>> call(
    List<OrderItemEntity> items,
  ) => repo.placeOrder(items);
}
