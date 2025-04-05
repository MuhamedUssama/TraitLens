import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileEntity {
  String? id;
  String? fullName;
  Timestamp? birthDay;
  String? phone;
  String? gender;
  String? profileImageUrl;
  String? email;

  UserProfileEntity({
    this.id,
    this.fullName,
    this.birthDay,
    this.phone,
    this.gender,
    this.profileImageUrl,
    this.email,
  });
}
