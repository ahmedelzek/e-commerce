import '../../../domain/entities/order/oder_response_entity.dart';
import 'orders_model.dart';

class OrdersResponseModel extends OrdersResponseEntity {
  const OrdersResponseModel({
    required super.status,
    required super.orders,
  });

  factory OrdersResponseModel.fromJson(Map<String, dynamic> json) =>
      OrdersResponseModel(
        status: json['status'],
        orders: OrdersModel.fromJson(json['orders']),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'orders': (orders as OrdersModel).toJson(),
  };
}