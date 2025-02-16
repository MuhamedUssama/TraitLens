import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../entities/profile_image_entity.dart';
import '../repository/fill_profile_repository.dart';

@injectable
class SetUserImageUsecase {
  final FillProfileRepository _repository;

  @factoryMethod
  SetUserImageUsecase(this._repository);

  Future<Either<ServerException, ProfileImageEntity>> call({
    String? imageUrl,
    File? imageFile,
  }) async {
    return await _repository.setProfileImage(
      imageUrl: imageUrl,
      imageFile: imageFile,
    );
  }
}
