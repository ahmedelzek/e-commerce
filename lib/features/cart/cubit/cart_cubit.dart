import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/domain/entities/product/product_entity.dart';

import '../../../domain/entities/cart/cart.dart';
import '../../../domain/use_cases/cart_use_cases.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartItemsUseCase getCartItemsUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final UpdateQuantityUseCase updateQuantityUseCase;
  final ClearCartUseCase clearCartUseCase;

  CartCubit({
    required this.getCartItemsUseCase,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.updateQuantityUseCase,
    required this.clearCartUseCase,
  }) : super(CartInitialState()) {
    loadCart();
  }

  static CartCubit get(context) => BlocProvider.of(context);

  List<CartItemEntity> items = [];

  void loadCart() {
    items = getCartItemsUseCase.getCartItems();
    if (items.isNotEmpty) {
      emit(CartUpdatedState(items: List.from(items)));
    }
  }

  Future<void> addToCart(ProductEntity product, int quantity) async {
    final index = items.indexWhere((e) => e.product.id == product.id);
    if (index != -1) {
      final newQty = items[index].quantity + quantity;
      items[index] = items[index].copyWith(quantity: newQty);
      await updateQuantityUseCase.updateQuantity(product.id, newQty);
    } else {
      items.add(CartItemEntity(product: product, quantity: quantity));
      await addToCartUseCase.addToCart(product, quantity);
    }
    emit(CartUpdatedState(items: List.from(items)));
  }

  Future<void> removeFromCart(int productId) async {
    items.removeWhere((e) => e.product.id == productId);
    await removeFromCartUseCase.removeFromCart(productId);
    emit(CartUpdatedState(items: List.from(items)));
  }

  Future<void> updateQuantity(int productId, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(productId);
      return;
    }
    final index = items.indexWhere((e) => e.product.id == productId);
    if (index != -1) {
      items[index] = items[index].copyWith(quantity: quantity);
      await updateQuantityUseCase.updateQuantity(productId, quantity);
      emit(CartUpdatedState(items: List.from(items)));
    }
  }

  Future<void> clearCart() async {
    items.clear();
    await clearCartUseCase.clearCart();
    emit(CartInitialState());
  }

  double get subtotal =>
      items.fold(0, (sum, e) => sum + (e.product.price * e.quantity));

  int get totalItems => items.fold(0, (sum, e) => sum + e.quantity);
}