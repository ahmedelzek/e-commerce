import '../../../domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.email,
    required super.favoriteProducts,
    required super.id,
    super.imagePath,
    required super.name,
    required super.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String,
      favoriteProducts: json['favorite_products'] as List<dynamic>? ?? [],
      id: json['id'] as int,
      imagePath: json['image_path'] as String?,
      name: json['name'] as String,
      phone: json['phone'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'favorite_products': favoriteProducts,
      'id': id,
      'image_path': imagePath,
      'name': name,
      'phone': phone,
    };
  }
}