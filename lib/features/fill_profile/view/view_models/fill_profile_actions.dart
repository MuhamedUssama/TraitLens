import 'package:cloud_firestore/cloud_firestore.dart';

import 'fill_profile_view_model.dart';

sealed class FillProfileActions {}

class FillProfileDataAction extends FillProfileActions {}

class CameraClickedAction extends FillProfileActions {}

class GalleryClickedAction extends FillProfileActions {}

class ChangeGenderAction extends FillProfileActions {
  Gender gender;

  ChangeGenderAction(this.gender);
}

class NavigateToHomeScreenAction extends FillProfileActions {}

class FormDataChangedAction extends FillProfileActions {}

class UpdateBirthdayAction extends FillProfileActions {
  final Timestamp birthdayTimestamp;

  UpdateBirthdayAction(this.birthdayTimestamp);
}
