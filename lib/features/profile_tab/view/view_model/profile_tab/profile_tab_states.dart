import '../../../../fill_profile/domain/entities/fill_profile_entity.dart';

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

class SignOutFailureState extends ProfileTabStates {
  String? errorMessage;

  SignOutFailureState(this.errorMessage);
}

class SignOutSuccessState extends ProfileTabStates {}

class ChangeLanguagesState extends ProfileTabStates {}

class NavigateToEditProfileScreenState extends ProfileTabStates {
  final UserProfileEntity? user;

  NavigateToEditProfileScreenState(this.user);
}

class NavigateToAboutUsScreenState extends ProfileTabStates {}

class NavigateToTermsAndConditionsScreenState extends ProfileTabStates {}
