import 'dart:io';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../entities/fill_profile_entity.dart';
import '../entities/profile_image_entity.dart';

abstract interface class FillProfileRepository {
  Future<Either<ServerException, UserProfileEntity>> setProfile({
    required String userId,
    required String fullName,
    required String birthDay,
    required String phone,
    required String gender,
  });

  Future<Either<ServerException, ProfileImageEntity>> setProfileImage({
    String? imageUrl,
    File? imageFile,
  });
}
