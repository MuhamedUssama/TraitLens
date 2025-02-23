import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    File? imageFile,
  }) async {
    try {
      String? profileImageUrl;
      if (imageFile != null) {
        final imageUploadResult = await _uploadImageToStorage(
          userId,
          imageFile,
        );
        imageUploadResult.fold(
          (error) => throw error,
          (url) => profileImageUrl = url,
        );
      }

      UserProfileModel userProfile = UserProfileModel(
        id: userId,
        fullName: fullName,
        birthDay: birthDay,
        phone: phone,
        gender: gender,
        profileImageUrl: profileImageUrl,
      );

      CollectionReference<UserProfileModel> userProfileCollection =
          FireBaseService.getUserProfileCollection(userId);

      await userProfileCollection.doc(userId).set(userProfile);

      return right(userProfile.toEntity());
    } on FirebaseException catch (exception) {
      return left(ServerException(exception.toString()));
    } catch (error) {
      return left(ServerException(error.toString()));
    }
  }

  Future<Either<ServerException, String>> _uploadImageToStorage(
    String userId,
    File? imageFile,
  ) async {
    try {
      if (imageFile == null) {
        return left(const ServerException("No image file provided"));
      }

      final imagePath =
          'profile_images/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';

      await Supabase.instance.client.storage.from('profileImages').upload(
          imagePath, imageFile,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true));

      final String imageUrl = Supabase.instance.client.storage
          .from('profileImages')
          .getPublicUrl(imagePath);

      return right(imageUrl);
    } on StorageException catch (exception) {
      return left(ServerException(exception.message));
    } catch (error) {
      return left(ServerException(error.toString()));
    }
  }
}
