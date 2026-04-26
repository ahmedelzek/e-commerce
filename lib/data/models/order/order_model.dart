import 'package:e_commerce/data/models/order/order_item_model.dart';
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
        .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    canceled: (json['canceled'] as List<dynamic>? ?? [])
        .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    completed: (json['completed'] as List<dynamic>? ?? [])
        .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'active': active.map((e) => (e as OrderItemModel).toJson()).toList(),
    'canceled': canceled.map((e) => (e as OrderItemModel).toJson()).toList(),
    'completed': completed.map((e) => (e as OrderItemModel).toJson()).toList(),
  };
}