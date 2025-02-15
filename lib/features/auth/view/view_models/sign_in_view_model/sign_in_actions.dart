sealed class SignInActions {}

class SignInWithEmailAndPasswordAction extends SignInActions {}

class SignInWithGoogleAction extends SignInActions {}

class SignInWithFacebookAction extends SignInActions {}

class ChangePasswordVisibilityAction extends SignInActions {}

class NavigateToSignUpScreenAction extends SignInActions {}

class NavigateToForgetPasswordScreenAction extends SignInActions {}

class NavigateToHomeScreenAction extends SignInActions {}
