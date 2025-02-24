import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_user_data_usecase.dart';
import 'profile_tab_actions.dart';
import 'profile_tab_states.dart';

@injectable
class ProfileTabViewModel extends Cubit<ProfileTabStates> {
  final GetUserDataUsecase _getUserDataUsecase;

  @factoryMethod
  ProfileTabViewModel(this._getUserDataUsecase)
      : super(ProfileTabInitialState());

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
      case ChangeLanguageAction():
      // TODO: Handle this case.
      case LogOutAction():
      // TODO: Handle this case.
    }
  }

  Future<void> _getUserData() async {
    emit(ProfileTabLoadingState());

    final result = await _getUserDataUsecase(
      userId: FirebaseAuth.instance.currentUser!.uid,
    );

    result.fold(
      (error) => emit(GetUserDataErrorState(error.message)),
      (user) => emit(GetUserDataSuccessState(user)),
    );
  }

  void _navigateToEditProfileScreen() {
    emit(NavigateToEditProfileScreenState());
  }

  void _navigateToAboutUsScreen() {
    emit(NavigateToAboutUsScreenState());
  }

  void _navigateToTermsAndConditionsScreen() {
    emit(NavigateToTermsAndConditionsScreenState());
  }
}
