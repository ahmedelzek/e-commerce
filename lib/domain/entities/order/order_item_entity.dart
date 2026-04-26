class OrderItemEntity {
  final int id;
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final double totalPrice;
  final int quantity;
  final double rating;

  const OrderItemEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.totalPrice,
    required this.quantity,
    required this.rating,
  });
}