import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/contract/order_repo.dart';

import '../entities/order/oder_response_entity.dart';

class GetOrdersUseCase {
  final OrderRepo repo;
  GetOrdersUseCase({required this.repo});

  Future<Either<String, OrdersResponseEntity>> call() =>
      repo.getOrders();
}