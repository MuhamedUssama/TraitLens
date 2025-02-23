sealed class ForgetPasswordStates {}

class ForgetPasswordInitialState extends ForgetPasswordStates {}

class ForgetPasswordLoadingState extends ForgetPasswordStates {}

class ForgetPasswordSuccessState extends ForgetPasswordStates {
  final String message;

  ForgetPasswordSuccessState(this.message);
}

class ForgetPasswordErrorState extends ForgetPasswordStates {
  final String message;

  ForgetPasswordErrorState(this.message);
}

class NavigateToLoginScreenState extends ForgetPasswordStates {}
