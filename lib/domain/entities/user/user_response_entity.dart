import 'user_entity.dart';

class UserResponseEntity {
  final bool status;
  final UserEntity user;

  const UserResponseEntity({
    required this.status,
    required this.user,
  });
}