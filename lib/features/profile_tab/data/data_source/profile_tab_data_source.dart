import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../fill_profile/domain/entities/fill_profile_entity.dart';

abstract interface class ProfileTabDataSource {
  Future<Either<ServerException, UserProfileEntity>> getUserData({
    required String userId,
  });

  Future<Either<ServerException, UserProfileEntity>> updateUserData({
    File? imageFile,
    String? name,
    Timestamp? birthday,
    String? phone,
    String? gender,
  });

  Future<Either<ServerException, void>> signOut();
}
