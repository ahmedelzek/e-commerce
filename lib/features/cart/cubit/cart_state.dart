
import '../../../domain/entities/cart/cart.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartUpdatedState extends CartState {
  final List<CartItemEntity> items;
  CartUpdatedState({required this.items});
}