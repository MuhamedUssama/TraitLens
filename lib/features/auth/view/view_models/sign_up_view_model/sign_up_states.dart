import 'package:trait_lens/features/auth/domain/entities/user_entity.dart';

sealed class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpSuccessState extends SignUpStates {
  UserEntity? userEntity;
  SignUpSuccessState(this.userEntity);
}

class SignUpErrorState extends SignUpStates {
  String message;
  SignUpErrorState(this.message);
}

class SignUpWithGoogleSuccessState extends SignUpStates {
  UserEntity? userEntity;
  SignUpWithGoogleSuccessState(this.userEntity);
}

class SignUpWithFacebookSuccessState extends SignUpStates {
  UserEntity? userEntity;
  SignUpWithFacebookSuccessState(this.userEntity);
}

class VerifyAccountState extends SignUpStates {
  String message;
  VerifyAccountState(this.message);
}

class NavigateToSignInScreenState extends SignUpStates {}

class NavigateToFillProfileScreenState extends SignUpStates {}
