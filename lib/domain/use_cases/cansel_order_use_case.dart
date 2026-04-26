import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/contract/order_repo.dart';
import 'package:e_commerce/domain/entities/order/place_order_response_entity.dart';

class CancelOrderUseCase {
  final OrderRepo repo;
  CancelOrderUseCase({required this.repo});

  Future<Either<String, PlaceOrderResponseEntity>> call(int orderId) =>
      repo.cancelOrder(orderId);
}