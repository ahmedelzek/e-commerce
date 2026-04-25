import 'package:e_commerce/data/models/product/product_model.dart';

import '../../../domain/entities/order/order_entity.dart';

class OrdersModel extends OrdersEntity {
  const OrdersModel({
    required super.active,
    required super.canceled,
    required super.completed,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
    active: (json['active'] as List<dynamic>? ?? [])
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    canceled: (json['canceled'] as List<dynamic>? ?? [])
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    completed: (json['completed'] as List<dynamic>? ?? [])
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'active': active.map((e) => (e as ProductModel).toJson()).toList(),
    'canceled': canceled.map((e) => (e as ProductModel).toJson()).toList(),
    'completed': completed.map((e) => (e as ProductModel).toJson()).toList(),
  };
}