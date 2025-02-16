import 'dart:io';

class FillProfileEntity {
  final String? fullName;
  final String? birthDay;
  final String? phone;
  final String? gender;
  final String? imageUrl;
  final File? imageFile;

  FillProfileEntity({
    this.fullName,
    this.birthDay,
    this.phone,
    this.gender,
    this.imageUrl,
    this.imageFile,
  });
}
