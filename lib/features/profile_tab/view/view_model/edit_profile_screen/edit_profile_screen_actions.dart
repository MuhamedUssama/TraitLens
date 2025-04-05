import 'package:cloud_firestore/cloud_firestore.dart';

import 'edit_profile_screen_view_model.dart';

sealed class EditProfileScreenActions {}

class UpdateUserDataAction extends EditProfileScreenActions {}

class ChangGenderAction extends EditProfileScreenActions {
  Gender gender;

  ChangGenderAction(this.gender);
}

class FormDataChangedAction extends EditProfileScreenActions {}

class CameraClickedAction extends EditProfileScreenActions {}

class GalleryClickedAction extends EditProfileScreenActions {}

class UpdateBirthdayAction extends EditProfileScreenActions {
  final Timestamp birthdayTimestamp;

  UpdateBirthdayAction(this.birthdayTimestamp);
}
