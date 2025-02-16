import 'dart:io';

class UserProfileEntity {
  final String? fullName;
  final String? birthDay;
  final String? phone;
  final String? gender;
  final String? imageUrl;
  final File? imageFile;

  UserProfileEntity({
    this.fullName,
    this.birthDay,
    this.phone,
    this.gender,
    this.imageUrl,
    this.imageFile,
  });
}
