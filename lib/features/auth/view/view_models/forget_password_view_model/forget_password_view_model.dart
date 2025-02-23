import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/forget_password_usecase.dart';
import 'forget_password_actions.dart';
import 'forget_password_states.dart';

@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordStates> {
  final ForgetPasswordUsecase _forgetPasswordUsecase;

  @factoryMethod
  ForgetPasswordViewModel(this._forgetPasswordUsecase)
      : super(ForgetPasswordInitialState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  Future<void> doIntent(ForgetPasswordActions actions) async {
    switch (actions) {
      case ForgetPasswordSubmitAction():
        _sendResetPasswordLink();
      case NavigateToLoginScreenAction():
        _navigateToLoginScreen();
    }
  }

  Future<void> _sendResetPasswordLink() async {
    if (formKey.currentState!.validate()) {
      emit(ForgetPasswordLoadingState());

      final result = await _forgetPasswordUsecase(email: emailController.text);

      result.fold(
        (failure) => emit(ForgetPasswordErrorState(failure.message.toString())),
        (message) => emit(ForgetPasswordSuccessState(message)),
      );
    }
  }

  void _navigateToLoginScreen() {
    emit(NavigateToLoginScreenState());
  }
}
