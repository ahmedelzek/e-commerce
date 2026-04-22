class UserEntity {
  final String email;
  final List<dynamic> favoriteProducts;
  final int id;
  final String? imagePath;
  final String name;
  final String phone;

  const UserEntity({
    required this.email,
    required this.favoriteProducts,
    required this.id,
    this.imagePath,
    required this.name,
    required this.phone,
  });
}