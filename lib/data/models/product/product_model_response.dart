

import '../../../domain/entities/product/product_entity_response.dart';
import 'product_model.dart';

class ProductResponseModel extends ProductResponseEntity {
  const ProductResponseModel({
    required super.status,
    required super.products,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductResponseModel(
      status: json['status'] as bool,
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'products': products
          .map((e) => (e as ProductModel).toJson())
          .toList(),
    };
  }
}