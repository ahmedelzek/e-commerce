class OrderItemRequestEntity {
  final int productId;
  final int quantity;

  const OrderItemRequestEntity({
    required this.productId,
    required this.quantity,
  });
}