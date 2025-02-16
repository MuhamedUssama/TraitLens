import 'dart:io';

class FillProfileModel {
  final String? fullName;
  final String? birthDay;
  final String? phone;
  final String? gender;
  final String? imageUrl;
  final File? imageFile;

  FillProfileModel({
    this.fullName,
    this.birthDay,
    this.phone,
    this.gender,
    this.imageUrl,
    this.imageFile,
  });

  factory FillProfileModel.fromJson(Map<String, dynamic> json) {
    return FillProfileModel(
      fullName: json['fullName'] as String?,
      birthDay: json['birthDay'] as String?,
      phone: json['phone'] as String?,
      gender: json['gender'] as String?,
      imageUrl: json['imageUrl'] as String?,
      imageFile: json['imageFile'] != null ? File(json['imageFile']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'birthDay': birthDay,
      'phone': phone,
      'gender': gender,
      'imageUrl': imageUrl,
      'imageFile': imageFile?.path,
    };
  }
}
