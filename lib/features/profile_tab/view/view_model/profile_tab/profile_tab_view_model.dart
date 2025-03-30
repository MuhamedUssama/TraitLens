import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../fill_profile/domain/entities/fill_profile_entity.dart';
import '../../../domain/usecases/get_user_data_usecase.dart';
import '../../../domain/usecases/sign_out_usecase.dart';
import 'profile_tab_actions.dart';
import 'profile_tab_states.dart';

@injectable
class ProfileTabViewModel extends Cubit<ProfileTabStates> {
  final GetUserDataUsecase _getUserDataUsecase;
  final SignOutUsecase _signOutUsecase;

  @factoryMethod
  ProfileTabViewModel(
    this._getUserDataUsecase,
    this._signOutUsecase,
  ) : super(ProfileTabInitialState());

  final String? email = FirebaseAuth.instance.currentUser?.email;

  ValueNotifier<bool> switcher = ValueNotifier(false);

  UserProfileEntity? userModel;

  Future<void> doIntent(ProfileTabActions actions) async {
    switch (actions) {
      case GetUserProfileDataAction():
        await _getUserData();
      case NavigateToEditProfileScreenAction():
        _navigateToEditProfileScreen();
      case NavigateToAboutUsScreenAction():
        _navigateToAboutUsScreen();
      case NavigateToTermsAndConditionsAction():
        _navigateToTermsAndConditionsScreen();
      case LogOutAction():
        await _logout();
      case NotificationSwitchAction():
        _switchNotiFication();
    }
  }

  Future<void> _getUserData() async {
    emit(ProfileTabLoadingState());

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(GetUserDataErrorState("User is not logged in"));
      return;
    }

    final result = await _getUserDataUsecase(userId: user.uid);

    result.fold(
      (error) => emit(GetUserDataErrorState(error.message)),
      (user) {
        userModel = user;
        return emit(GetUserDataSuccessState(user));
      },
    );
  }

  Future<void> _logout() async {
    emit(ProfileTabLoadingState());

    final result = await _signOutUsecase();

    result.fold(
      (failure) => emit(SignOutFailureState(failure.message)),
      (success) => emit(SignOutSuccessState()),
    );
  }

  void _navigateToEditProfileScreen() {
    emit(NavigateToEditProfileScreenState(userModel));
  }

  void _navigateToAboutUsScreen() {
    emit(NavigateToAboutUsScreenState());
  }

  void _navigateToTermsAndConditionsScreen() {
    emit(NavigateToTermsAndConditionsScreenState());
  }

  void _switchNotiFication() {
    switcher.value = !switcher.value;
  }
}
