import 'dart:io';

import '../../../../fill_profile/domain/entities/fill_profile_entity.dart';

sealed class EditProfileScreenStates {}

class EditProfileInitialState extends EditProfileScreenStates {}

class EditProfileLoadingState extends EditProfileScreenStates {}

class EditProfileSuccessState extends EditProfileScreenStates {
  UserProfileEntity? entity;

  EditProfileSuccessState(this.entity);
}

class EditProfileFailureState extends EditProfileScreenStates {
  String? message;
  EditProfileFailureState(this.message);
}

class ChangeGenderState extends EditProfileScreenStates {}

class ImageSelectedState extends EditProfileScreenStates {
  final File imageFile;
  ImageSelectedState(this.imageFile);
}
