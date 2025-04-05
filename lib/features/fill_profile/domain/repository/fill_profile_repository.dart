import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../entities/fill_profile_entity.dart';

abstract interface class FillProfileRepository {
  Future<Either<ServerException, UserProfileEntity>> setProfile({
    required String userId,
    required String fullName,
    required Timestamp birthDayTimestamp,
    required String phone,
    required String gender,
    File? imageFile,
  });
}
