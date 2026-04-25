import '../contract/cart_repo.dart';
import '../entities/cart/cart.dart';
import '../entities/product/product_entity.dart';

class GetCartItemsUseCase {
  final CartRepo repo;
  GetCartItemsUseCase({required this.repo});
  List<CartItemEntity> getCartItems() => repo.getCartItems();
}

class AddToCartUseCase {
  final CartRepo repo;
  AddToCartUseCase({required this.repo});
  Future<void> addToCart(ProductEntity product, int quantity) =>
      repo.addToCart(product, quantity);
}

class RemoveFromCartUseCase {
  final CartRepo repo;
  RemoveFromCartUseCase({required this.repo});
  Future<void> removeFromCart(int productId) =>
      repo.removeFromCart(productId);
}

class UpdateQuantityUseCase {
  final CartRepo repo;
  UpdateQuantityUseCase({required this.repo});
  Future<void> updateQuantity(int productId, int quantity) =>
      repo.updateQuantity(productId, quantity);
}

class ClearCartUseCase {
  final CartRepo repo;
  ClearCartUseCase({required this.repo});
  Future<void> clearCart() => repo.clearCart();
}