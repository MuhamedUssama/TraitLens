import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image/image.dart' as img;
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
    required Timestamp birthDayTimestamp,
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
        email: FirebaseAuth.instance.currentUser?.email ?? 'no email found',
        fullName: fullName,
        birthDay: birthDayTimestamp,
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

  Future<void> _deleteOldImages(String userId) async {
    final SupabaseStorageClient storage = Supabase.instance.client.storage;

    final List<FileObject> response = await storage
        .from('profileImages')
        .list(path: 'profile_images/$userId/');

    for (FileObject file in response) {
      await storage
          .from('profileImages')
          .remove(['profile_images/$userId/${file.name}']);
    }
  }

  Future<File> _compressImage(File imageFile, {int quality = 75}) async {
    Uint8List imageBytes = await imageFile.readAsBytes();
    img.Image? image = img.decodeImage(imageBytes);
    if (image == null) {
      throw Exception("Failed to decode image");
    }
    Uint8List compressedBytes =
        Uint8List.fromList(img.encodeJpg(image, quality: quality));

    final Directory tempDir = Directory.systemTemp;
    final File compressedFile = File('${tempDir.path}/compressed_image.jpg');
    await compressedFile.writeAsBytes(compressedBytes);

    return compressedFile;
  }

  Future<Either<ServerException, String>> _uploadImageToStorage(
    String userId,
    File? imageFile,
  ) async {
    try {
      if (imageFile == null) {
        return left(const ServerException("No image file provided"));
      }

      await _deleteOldImages(userId);

      File compressedImage = await _compressImage(imageFile, quality: 75);

      final String imagePath =
          'profile_images/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';

      await Supabase.instance.client.storage.from('profileImages').upload(
            imagePath,
            compressedImage,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );

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
