import 'package:hive/hive.dart';

part 'cart_item_hive_model.g.dart';

@HiveType(typeId: 0)
class CartItemHiveModel extends HiveObject {
  @HiveField(0)
  final int productId;

  @HiveField(1)
  final String productName;

  @HiveField(2)
  final String productImage;

  @HiveField(3)
  final double productPrice;

  @HiveField(4)
  final double productRating;

  @HiveField(5)
  final String productDescription;

  @HiveField(6)
  final bool isFavorite;

  @HiveField(7)
  final int bestSeller;

  @HiveField(8)
  int quantity;

  CartItemHiveModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productRating,
    required this.productDescription,
    required this.isFavorite,
    required this.bestSeller,
    required this.quantity,
  });
}