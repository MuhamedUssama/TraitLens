import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../fill_profile/domain/entities/fill_profile_entity.dart';

abstract interface class ProfileTabRepository {
  Future<Either<ServerException, UserProfileEntity>> getUserData({
    required String userId,
  });

  Future<Either<ServerException, UserProfileEntity>> updateUserData({
    File? imageFile,
    String? name,
    String? birthday,
    String? phone,
    String? gender,
  });

  Future<Either<ServerException, void>> signOut();
}
