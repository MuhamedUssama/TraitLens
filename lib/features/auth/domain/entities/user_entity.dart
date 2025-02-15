class UserEntity {
  static const String userCollection = 'users';
  final String id;
  final String email;

  UserEntity({
    required this.id,
    required this.email,
  });
}
