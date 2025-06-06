import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/fill_profile_entity.dart';

sealed class FillProfileStates {}

class FillProfileInitialState extends FillProfileStates {}

class FillProfileLoadingState extends FillProfileStates {}

class FillProfileErrorState extends FillProfileStates {
  String? message;

  FillProfileErrorState(this.message);
}

class FillProfileSuccessState extends FillProfileStates {
  UserProfileEntity? entity;

  FillProfileSuccessState(this.entity);
}

class ChangeGenderState extends FillProfileStates {}

class ImageSelectedState extends FillProfileStates {
  final File imageFile;
  ImageSelectedState(this.imageFile);
}

class NavigateToHomeScreenState extends FillProfileStates {}

class BirthdayUpdatedState extends FillProfileStates {
  final Timestamp birthdayTimestamp;

  BirthdayUpdatedState(this.birthdayTimestamp);
}
