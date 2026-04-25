import 'package:e_commerce/domain/contract/cart_repo.dart';
import 'package:e_commerce/domain/entities/product/product_entity.dart';

import '../../core/local_data_source/cart_local_data_source.dart';
import '../../domain/entities/cart/cart.dart';
import '../models/cart/cart_item_hive_model.dart';

class CartRepoImpl extends CartRepo {
  final CartLocalDataSource localDataSource;

  CartRepoImpl({required this.localDataSource});

  @override
  List<CartItemEntity> getCartItems() {
    return localDataSource
        .getAll()
        .map(
          (e) => CartItemEntity(
            product: ProductEntity(
              id: e.productId,
              name: e.productName,
              imagePath: e.productImage,
              price: e.productPrice,
              rating: e.productRating,
              description: e.productDescription,
              isFavorite: e.isFavorite,
              bestSeller: e.bestSeller,
              category: null,
            ),
            quantity: e.quantity,
          ),
        )
        .toList();
  }

  @override
  Future<void> addToCart(ProductEntity product, int quantity) async {
    await localDataSource.save(
      CartItemHiveModel(
        productId: product.id,
        productName: product.name,
        productImage: product.imagePath,
        productPrice: product.price,
        productRating: product.rating,
        productDescription: product.description,
        isFavorite: product.isFavorite,
        bestSeller: product.bestSeller,
        quantity: quantity,
      ),
    );
  }

  @override
  Future<void> removeFromCart(int productId) async {
    await localDataSource.remove(productId);
  }

  @override
  Future<void> updateQuantity(int productId, int quantity) async {
    final items = localDataSource.getAll();
    final item = items.firstWhere((e) => e.productId == productId);
    await localDataSource.save(
      CartItemHiveModel(
        productId: item.productId,
        productName: item.productName,
        productImage: item.productImage,
        productPrice: item.productPrice,
        productRating: item.productRating,
        productDescription: item.productDescription,
        isFavorite: item.isFavorite,
        bestSeller: item.bestSeller,
        quantity: quantity,
      ),
    );
  }

  @override
  Future<void> clearCart() async {
    await localDataSource.clear();
  }
}
