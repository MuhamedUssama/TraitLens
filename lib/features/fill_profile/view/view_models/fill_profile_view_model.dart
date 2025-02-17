import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/image_picker_utils.dart';
import '../../domain/usecases/fill_profile_data_usecase.dart';
import '../../domain/usecases/set_user_image_usecase.dart';
import 'fill_profile_actions.dart';
import 'fill_profile_states.dart';

@injectable
class FillProfileViewModel extends Cubit<FillProfileStates> {
  final FillProfileDataUsecase _fillProfileDataUsecase;
  final SetUserImageUsecase _setUserImageUsecase;

  @factoryMethod
  FillProfileViewModel(
    this._fillProfileDataUsecase,
    this._setUserImageUsecase,
  ) : super(FillProfileInitialState());

  ValueNotifier<Gender> selectedGender = ValueNotifier(Gender.female);

  String? imageUrl;
  File? imageFile;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> doIntent(FillProfileActions actions) async {
    switch (actions) {
      case FillProfileDataAction():
        await _updateUserProfile();
      case ChangeProfileImageAction():
        await _changeProfileImage();
      case CameraClickedAction():
        await _clickOnCameraButton();
      case GalleryClickedAction():
        await _clickOnGalleryButton();
      case NavigateToHomeScreenAction():
        _navigateToHomeScreen();
      case ChangeGenderAction():
        _changeGender();
    }
  }

  Future<void> _updateUserProfile() async {
    try {
      emit(FillProfileLoadingState());

      final result = await _fillProfileDataUsecase(
        userId: FirebaseAuth.instance.currentUser!.uid,
        fullName: nameController.text,
        birthDay: birthdayController.text,
        phone: phoneController.text,
        gender: selectedGender.value == Gender.female ? "female" : "male",
      );

      emit(FillProfileHideLoadingState());

      result.fold(
        (error) => emit(FillProfileErrorState(error.message)),
        (user) => emit(FillProfileSuccessState(user)),
      );
    } catch (error) {
      emit(FillProfileErrorState(error.toString()));
    }
  }

  Future<void> _changeProfileImage() async {
    try {
      emit(FillProfileLoadingState());

      final result = await _setUserImageUsecase(
        imageUrl: imageUrl,
        imageFile: imageFile,
      );

      emit(FillProfileHideLoadingState());

      result.fold(
        (error) => emit(FillProfileErrorState(error.message)),
        (image) => emit(ChangeImageState(image)),
      );
    } catch (error) {
      emit(FillProfileErrorState(error.toString()));
    }
  }

  Future<void> _clickOnCameraButton() async {
    await ImagePickerUtils.cameraPicker();
  }

  Future<void> _clickOnGalleryButton() async {
    await ImagePickerUtils.galleryPicker();
  }

  void _changeGender() {
    selectedGender.value =
        selectedGender.value == Gender.female ? Gender.male : Gender.female;
    log('selectedGender: ${selectedGender.value}');
    emit(ChangeGenderState());
  }

  void _navigateToHomeScreen() {
    emit(NavigateToHomeScreenState());
  }
}

enum Gender { male, female }
