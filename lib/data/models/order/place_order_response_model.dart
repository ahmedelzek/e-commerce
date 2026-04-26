import '../../../domain/entities/order/place_order_response_entity.dart';

class PlaceOrderResponseModel extends PlaceOrderResponseEntity {
  const PlaceOrderResponseModel({
    required super.status,
    required super.message,
  });

  factory PlaceOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      PlaceOrderResponseModel(
        status: json['status'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
  };
}