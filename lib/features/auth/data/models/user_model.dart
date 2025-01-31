class UserModel {
  static const String userCollection = 'users';
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
}
