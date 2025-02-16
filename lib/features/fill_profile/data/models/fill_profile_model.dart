import 'dart:io';

import '../../domain/entities/fill_profile_entity.dart';

class UserProfileModel {
  final String? fullName;
  final String? birthDay;
  final String? phone;
  final String? gender;
  final String? imageUrl;
  final File? imageFile;

  UserProfileModel({
    this.fullName,
    this.birthDay,
    this.phone,
    this.gender,
    this.imageUrl,
    this.imageFile,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
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

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      fullName: fullName,
      birthDay: birthDay,
      phone: phone,
      gender: gender,
      imageUrl: imageUrl,
      imageFile: imageFile,
    );
  }
}
