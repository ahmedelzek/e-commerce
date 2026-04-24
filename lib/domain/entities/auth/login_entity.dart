import 'package:e_commerce/domain/entities/user/user_entity.dart';

class LoginEntity {
  final String accessToken;
  final String refreshToken;
  final bool status;
  final UserEntity user;

  const LoginEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.status,
    required this.user,
  });
}