import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/sign_in_with_email_and_password_usecase.dart';
import '../../../domain/use_cases/sign_in_with_facebook_usecase.dart';
import '../../../domain/use_cases/sign_in_with_google_usecase.dart';
import 'sign_in_actions.dart';
import 'sign_in_states.dart';

@injectable
class SignInViewModel extends Cubit<SignInStates> {
  final SignInWithEmailAndPasswordUsecase _signInWithEmailAndPasswordUsecase;
  final SignInWithFacebookUsecase _signInWithFacebookUsecase;
  final SignInWithGoogleUsecase _signInWithGoogleUsecase;

  @factoryMethod
  SignInViewModel(
    this._signInWithEmailAndPasswordUsecase,
    this._signInWithFacebookUsecase,
    this._signInWithGoogleUsecase,
  ) : super(SignInInitialState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<bool> valid = ValueNotifier(false);
  final ValueNotifier<bool> passwordVisible = ValueNotifier(true);

  Future<void> doIntent(SignInActions actions) async {
    switch (actions) {
      case SignInWithEmailAndPasswordAction():
        _signInWithEmailAndPassword();
      case SignInWithGoogleAction():
        _signInWithGoogle();
      case SignInWithFacebookAction():
        _signInWithFacebook();
      case ChangePasswordVisibilityAction():
        _changePasswordVisibility();
      case NavigateToSignUpScreenAction():
        _navigateToSignUpScreen();
      case NavigateToForgetPasswordScreenAction():
        _navigateToForgetPasswordScreen();
      case NavigateToHomeScreenAction():
        _navigateToHomeScreen();
      case FormDataChangedAction():
        _updateValidationState();
    }
  }

  void _updateValidationState() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      valid.value = false;
    } else if (!formKey.currentState!.validate()) {
      valid.value = false;
    } else {
      valid.value = true;
    }
  }

  Future<void> _signInWithEmailAndPassword() async {
    if (formKey.currentState!.validate()) {
      emit(SignInLoadingState());

      final result = await _signInWithEmailAndPasswordUsecase(
        email: emailController.text,
        password: passwordController.text,
      );

      result.fold(
        (error) => emit(SignInErrorState(error.message.toString())),
        (userEntity) => emit(SignInSuccessState(userEntity)),
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    emit(SignInLoadingState());

    final result = await _signInWithGoogleUsecase();

    result.fold(
      (error) => emit(SignInErrorState(error.message.toString())),
      (userEntity) => emit(SignInWithGoogleState(userEntity)),
    );
  }

  Future<void> _signInWithFacebook() async {
    emit(SignInLoadingState());

    final result = await _signInWithFacebookUsecase();

    result.fold(
      (error) => emit(SignInErrorState(error.message.toString())),
      (userEntity) => emit(SignInWithFacebookState(userEntity)),
    );
  }

  void _changePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  void _navigateToForgetPasswordScreen() {
    emit(NavigateToForgetPasswordScreenState());
  }

  void _navigateToHomeScreen() {
    emit(NavigateToHomeScreenState());
  }

  void _navigateToSignUpScreen() {
    emit(NavigateToSignUpScreenState());
  }
}
