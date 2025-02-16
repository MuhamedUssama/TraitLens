import '../../domain/entities/fill_profile_entity.dart';

class UserProfileModel {
  static const String collectionName = 'userProfile';

  String? id;
  String? fullName;
  String? birthDay;
  String? phone;
  String? gender;

  UserProfileModel({
    this.id,
    this.fullName,
    this.birthDay,
    this.phone,
    this.gender,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      birthDay: json['birthDay'] as String?,
      phone: json['phone'] as String?,
      gender: json['gender'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'birthDay': birthDay,
      'phone': phone,
      'gender': gender,
    };
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      id: id,
      fullName: fullName,
      birthDay: birthDay,
      phone: phone,
      gender: gender,
    );
  }
}
