import 'package:e_commerce/domain/entities/product/product_entity.dart';

class OrdersEntity {
  final List<ProductEntity> active;
  final List<ProductEntity> canceled;
  final List<ProductEntity> completed;

  const OrdersEntity({
    required this.active,
    required this.canceled,
    required this.completed,
  });
}