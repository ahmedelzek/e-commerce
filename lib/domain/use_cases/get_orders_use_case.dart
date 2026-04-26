import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/contract/order_repo.dart';

import '../entities/order/orders_entity.dart';

class GetOrdersUseCase {
  final OrderRepo repo;
  GetOrdersUseCase({required this.repo});

  Future<Either<String, OrdersEntity>> call() =>
      repo.getOrders();
}