import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../entities/fill_profile_entity.dart';
import '../repository/fill_profile_repository.dart';

@injectable
class FillProfileDataUsecase {
  final FillProfileRepository repository;

  @factoryMethod
  FillProfileDataUsecase(this.repository);

  Future<Either<ServerException, UserProfileEntity>> call({
    required String userId,
    required String fullName,
    required Timestamp birthDayTimestamp,
    required String phone,
    required String gender,
    File? imageFile,
  }) async {
    return await repository.setProfile(
      userId: userId,
      fullName: fullName,
      birthDayTimestamp: birthDayTimestamp,
      phone: phone,
      gender: gender,
      imageFile: imageFile,
    );
  }
}
