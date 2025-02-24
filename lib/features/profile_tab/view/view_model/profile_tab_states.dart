import '../../../fill_profile/domain/entities/fill_profile_entity.dart';

sealed class ProfileTabStates {}

class ProfileTabInitialState extends ProfileTabStates {}

class ProfileTabLoadingState extends ProfileTabStates {}

class GetUserDataSuccessState extends ProfileTabStates {
  UserProfileEntity? user;

  GetUserDataSuccessState(this.user);
}

class GetUserDataErrorState extends ProfileTabStates {
  String? errorMessage;

  GetUserDataErrorState(this.errorMessage);
}

class ChangeLanguagesState extends ProfileTabStates {}

class NavigateToEditProfileScreenState extends ProfileTabStates {}

class NavigateToAboutUsScreenState extends ProfileTabStates {}

class NavigateToTermsAndConditionsScreenState extends ProfileTabStates {}

class LogOutState extends ProfileTabStates {}
