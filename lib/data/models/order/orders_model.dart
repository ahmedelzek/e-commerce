import 'package:e_commerce/data/models/order/order_model.dart';

import '../../../domain/entities/order/orders_entity.dart';

class OrdersModel extends OrdersEntity {
  const OrdersModel({
    required super.active,
    required super.canceled,
    required super.completed,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    final orders = json['orders'] as Map<String, dynamic>;

    return OrdersModel(
      active: (orders['active'] as List<dynamic>? ?? [])
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      canceled: (orders['canceled'] as List<dynamic>? ?? [])
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      completed: (orders['completed'] as List<dynamic>? ?? [])
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'orders': {
      'active': active.map((e) => (e as OrderModel).toJson()).toList(),
      'canceled': canceled.map((e) => (e as OrderModel).toJson()).toList(),
      'completed': completed.map((e) => (e as OrderModel).toJson()).toList(),
    },
  };
}