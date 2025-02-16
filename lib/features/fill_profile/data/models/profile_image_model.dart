import 'dart:io';

import '../../domain/entities/profile_image_entity.dart';

class ProfileImageModel {
  String? imageUrl;
  File? imageFile;

  ProfileImageModel({this.imageUrl, this.imageFile});

  factory ProfileImageModel.fromJson(Map<String, dynamic> json) {
    return ProfileImageModel(
      imageUrl: json['imageUrl'],
      imageFile: json['imageFile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'imageFile': imageFile,
    };
  }

  ProfileImageEntity toEntity() {
    return ProfileImageEntity(
      imageUrl: imageUrl,
      imageFile: imageFile,
    );
  }
}
