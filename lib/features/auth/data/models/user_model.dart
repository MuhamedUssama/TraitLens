import 'package:trait_lens/features/auth/domain/entities/user_entity.dart';

class UserModel {
  static const String collectionName = 'users';
  final String id;
  final String email;

  UserModel({
    required this.id,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) => UserModel(
        id: map['id'],
        email: map['email'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
      };

  UserEntity toEntity() => UserEntity(id: id, email: email);
}
