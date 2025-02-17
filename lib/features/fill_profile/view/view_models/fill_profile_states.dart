import '../../domain/entities/fill_profile_entity.dart';
import '../../domain/entities/profile_image_entity.dart';

sealed class FillProfileStates {}

class FillProfileInitialState extends FillProfileStates {}

class FillProfileLoadingState extends FillProfileStates {}

class FillProfileHideLoadingState extends FillProfileStates {}

class FillProfileErrorState extends FillProfileStates {
  String? message;

  FillProfileErrorState(this.message);
}

class FillProfileSuccessState extends FillProfileStates {
  UserProfileEntity? entity;

  FillProfileSuccessState(this.entity);
}

class ChangeGenderState extends FillProfileStates {}

class ChangeImageState extends FillProfileStates {
  ProfileImageEntity? entity;

  ChangeImageState(this.entity);
}

class NavigateToHomeScreenState extends FillProfileStates {}
