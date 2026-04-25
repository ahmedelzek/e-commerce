import '../entities/cart/cart.dart';
import '../entities/product/product_entity.dart';

abstract class CartRepo {
  List<CartItemEntity> getCartItems();
  Future<void> addToCart(ProductEntity product, int quantity);
  Future<void> removeFromCart(int productId);
  Future<void> updateQuantity(int productId, int quantity);
  Future<void> clearCart();
}