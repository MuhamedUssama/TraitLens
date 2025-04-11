import 'package:trait_lens/features/auth/domain/entities/user_entity.dart';

class UserModel {
  static const String collectionName = 'users';
  final String id;
  final String email;
  final String role;

  UserModel({
    required this.id,
    required this.email,
    this.role = 'user',
  });

  factory UserModel.fromJson(Map<String, dynamic> map) => UserModel(
        id: map['id'],
        email: map['email'],
        role: (map['role'] as String?) ?? 'user',
      );

  Map<String, dynamic> toJson() => {'id': id, 'email': email, 'role': role};

  UserEntity toEntity() => UserEntity(id: id, email: email);
}
