import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/firebase_services.dart';
import '../../domain/entities/fill_profile_entity.dart';
import '../data_source/fill_profile_data_source.dart';
import '../models/fill_profile_model.dart';

@Injectable(as: FillProfileDataSource)
class FillProfileDataSourceImpl implements FillProfileDataSource {
  @override
  Future<Either<ServerException, UserProfileEntity>> setProfile({
    required String userId,
    required String fullName,
    required String birthDay,
    required String phone,
    required String gender,
  }) async {
    try {
      UserProfileModel userProfile = UserProfileModel(
        id: userId,
        fullName: fullName,
        birthDay: birthDay,
        phone: phone,
        gender: gender,
      );

      CollectionReference<UserProfileModel> userProfileCollection =
          FireBaseService.getUserProfileCollection(userId);

      await userProfileCollection.doc(userId).set(userProfile);

      return Right(userProfile.toEntity());
    } on FirebaseException catch (exception) {
      return Left(ServerException(exception.toString()));
    } catch (error) {
      return Left(ServerException(error.toString()));
    }
  }

  @override
  Future<Either<ServerException, UserProfileEntity>> setProfileImage(
      {String? imageUrl, File? imageFile}) {
    // TODO: implement setProfileImage
    throw UnimplementedError();
  }
}
