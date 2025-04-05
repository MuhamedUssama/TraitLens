import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/image_picker_utils.dart';
import '../../domain/usecases/fill_profile_data_usecase.dart';
import 'fill_profile_actions.dart';
import 'fill_profile_states.dart';

@injectable
class FillProfileViewModel extends Cubit<FillProfileStates> {
  final FillProfileDataUsecase _fillProfileDataUsecase;

  @factoryMethod
  FillProfileViewModel(
    this._fillProfileDataUsecase,
  ) : super(FillProfileInitialState());

  String? imageUrl;
  File? imageFile;
  Timestamp? birthdayTimestamp;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  ValueNotifier<bool> valid = ValueNotifier(false);
  Gender selectedGender = Gender.female;

  Future<void> doIntent(FillProfileActions actions) async {
    switch (actions) {
      case FillProfileDataAction():
        await _updateUserProfile();
      case CameraClickedAction():
        await _clickOnCameraButton();
      case GalleryClickedAction():
        await _clickOnGalleryButton();
      case NavigateToHomeScreenAction():
        _navigateToHomeScreen();
      case ChangeGenderAction():
        _changeGender();
      case FormDataChangedAction():
        _updateValidationState();
      case UpdateBirthdayAction(:final birthdayTimestamp):
        _updateBirthday(birthdayTimestamp);
    }
  }

  Future<void> _updateUserProfile() async {
    try {
      if (formKey.currentState!.validate() && birthdayTimestamp != null) {
        emit(FillProfileLoadingState());

        final result = await _fillProfileDataUsecase(
          userId: FirebaseAuth.instance.currentUser!.uid,
          fullName: nameController.text,
          phone: phoneController.text,
          gender: selectedGender == Gender.female ? "female" : "male",
          imageFile: imageFile,
          birthDayTimestamp: birthdayTimestamp!,
        );

        result.fold(
          (error) => emit(FillProfileErrorState(error.message)),
          (user) => emit(FillProfileSuccessState(user)),
        );
      }
    } catch (error) {
      emit(FillProfileErrorState(error.toString()));
    }
  }

  void _updateValidationState() {
    if (nameController.text.isEmpty ||
        birthdayController.text.isEmpty ||
        phoneController.text.isEmpty) {
      valid.value = false;
    } else if (!formKey.currentState!.validate()) {
      valid.value = false;
    } else {
      valid.value = true;
    }
  }

  Future<void> _clickOnCameraButton() async {
    imageFile = await ImagePickerUtils.cameraPicker();
    if (imageFile != null) {
      emit(ImageSelectedState(imageFile!));
    }
  }

  Future<void> _clickOnGalleryButton() async {
    imageFile = await ImagePickerUtils.galleryPicker();
    if (imageFile != null) {
      emit(ImageSelectedState(imageFile!));
    }
  }

  void _changeGender() {
    selectedGender =
        selectedGender == Gender.female ? Gender.male : Gender.female;
    emit(ChangeGenderState());
  }

  void _navigateToHomeScreen() {
    emit(NavigateToHomeScreenState());
  }

  void _updateBirthday(Timestamp birthdayTimestamp) {
    log('>>> Updating birthday to: ${birthdayTimestamp.toDate()}');

    this.birthdayTimestamp = birthdayTimestamp;
    emit(BirthdayUpdatedState(birthdayTimestamp));
  }
}

enum Gender { male, female }
