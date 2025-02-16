import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/firebase_services.dart';
import '../../domain/entities/fill_profile_entity.dart';
import '../../domain/entities/profile_image_entity.dart';
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

      return right(userProfile.toEntity());
    } on FirebaseException catch (exception) {
      return left(ServerException(exception.toString()));
    } catch (error) {
      return left(ServerException(error.toString()));
    }
  }

  @override
  Future<Either<ServerException, ProfileImageEntity>> setProfileImage({
    String? imageUrl,
    File? imageFile,
  }) async {
    try {
      firebase_auth.User user =
          firebase_auth.FirebaseAuth.instance.currentUser!;

      String? finalImageUrl = imageUrl;
      File? finalImageFile = imageFile;

      if (_getProviderType(user) == 'password') {
        if (imageFile != null) {
          if (imageUrl != null && imageUrl.isNotEmpty) {
            final imagePath = Uri.parse(imageUrl).pathSegments.last;
            await Supabase.instance.client.storage
                .from('profileImages')
                .remove([imagePath]);
          }

          final result = await _uploadImageToStorage(user.uid, imageFile);
          result.fold(
            (error) => ServerException(error.toString()),
            (url) => finalImageUrl = url,
          );
        } else {
          return left(const ServerException("No image file provided"));
        }
      } else {
        finalImageUrl = user.photoURL ?? '';
        finalImageFile = null;
      }

      if (finalImageUrl == null || finalImageUrl!.isEmpty) {
        return left(const ServerException("Failed to get profile image URL"));
      }

      CollectionReference<UserProfileModel> userProfileCollection =
          FireBaseService.getUserProfileCollection(user.uid);

      await userProfileCollection.doc(user.uid).update({
        'profileImage': finalImageUrl,
      });

      return right(
        ProfileImageEntity(
          imageUrl: finalImageUrl,
          imageFile: finalImageFile,
        ),
      );
    } on FirebaseException catch (exception) {
      return left(ServerException(exception.toString()));
    } catch (error) {
      return left(ServerException(error.toString()));
    }
  }

  String _getProviderType(firebase_auth.User user) {
    return user.providerData.map((provider) => provider.providerId).firstWhere(
          (id) => ['password', 'google.com', 'facebook.com'].contains(id),
          orElse: () => 'Unknown',
        );
  }

  Future<Either<ServerException, String>> _uploadImageToStorage(
      String userId, File? imageFile) async {
    try {
      if (imageFile == null) {
        return left(const ServerException("No image file provided"));
      }

      final imagePath =
          'profile_images/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';

      await Supabase.instance.client.storage.from('profileImages').upload(
          imagePath, imageFile,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true));

      final imageUrl = Supabase.instance.client.storage
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
