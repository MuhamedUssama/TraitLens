import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/utils/image_picker_utils.dart';
import '../../../domain/usecases/update_user_data_usecase.dart';
import 'edit_profile_screen_actions.dart';
import 'edit_profile_screen_states.dart';

@injectable
class EditProfileScreenViewModel extends Cubit<EditProfileScreenStates> {
  final UpdateUserDataUsecase _updateUserDataUsecase;

  @factoryMethod
  EditProfileScreenViewModel(this._updateUserDataUsecase)
      : super(EditProfileInitialState());

  File? imageFile;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  ValueNotifier<bool> valid = ValueNotifier(false);
  late Gender selectedGender;

  Future<void> doIntent(EditProfileScreenActions actions) async {
    switch (actions) {
      case UpdateUserDataAction():
        await _updateUserData();
      case ChangGenderAction():
        _changeGender();
      case FormDataChangedAction():
        _updateValidationState();
      case CameraClickedAction():
        await _clickOnCameraButton();
      case GalleryClickedAction():
        await _clickOnGalleryButton();
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

  Future<void> _updateUserData() async {
    try {
      if (formKey.currentState!.validate()) {
        emit(EditProfileLoadingState());

        final result = await _updateUserDataUsecase(
          name: nameController.text,
          birthday: birthdayController.text,
          phone: phoneController.text,
          imageFile: imageFile,
          gender: selectedGender == Gender.female ? "female" : "male",
        );

        result.fold(
          (failure) => emit(EditProfileFailureState(failure.message)),
          (user) => emit(EditProfileSuccessState(user)),
        );
      }
    } catch (error) {
      emit(EditProfileFailureState(error.toString()));
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
}

enum Gender { male, female }
