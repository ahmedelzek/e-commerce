import 'package:e_commerce/domain/entities/order/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imagePath,
    required super.price,
    required super.totalPrice,
    required super.quantity,
    required super.rating,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imagePath: json['image_path'],
      price: (json['price'] as num).toDouble(),
      totalPrice: (json['total_price'] as num).toDouble(),
      quantity: json['quantity'],
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_path': imagePath,
      'price': price,
      'total_price': totalPrice,
      'quantity': quantity,
      'rating': rating,
    };
  }
}