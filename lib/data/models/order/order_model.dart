import 'package:e_commerce/domain/entities/order/order_entity.dart';
import '../../../domain/entities/order/driver_entity.dart';
import 'order_item_model.dart';

class DriverModel extends DriverEntity {
  const DriverModel({
    required super.name,
    required super.phone,
    required super.latitude,
    required super.longitude,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
    name: json['name'] as String,
    phone: json['phone'] as String,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'latitude': latitude,
    'longitude': longitude,
  };
}

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.status,
    required super.orderDate,
    super.orderChangeDate,
    required super.subtotal,
    required super.shipping,
    required super.tax,
    required super.total,
    super.driver,
    required super.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json['id'] as int,
    status: json['status'] as int,
    orderDate: json['order_date'] as String,
    orderChangeDate: json['order_change_date'] as String?,
    subtotal: (json['subtotal'] as num).toDouble(),
    shipping: (json['shipping'] as num).toDouble(),
    tax: (json['tax'] as num).toDouble(),
    total: (json['total'] as num).toDouble(),
    driver: json['driver'] != null
        ? DriverModel.fromJson(json['driver'] as Map<String, dynamic>)
        : null,
    items: (json['items'] as List<dynamic>)
        .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'status': status,
    'order_date': orderDate,
    'order_change_date': orderChangeDate,
    'subtotal': subtotal,
    'shipping': shipping,
    'tax': tax,
    'total': total,
    'driver': (driver as DriverModel?)?.toJson(),
    'items': items.map((e) => (e as OrderItemModel).toJson()).toList(),
  };
}