import 'app_strings.dart';

class AppValidator {
  static String? validateEmailAddress(String? email) {
    if (email == null || email.trim().isEmpty) {
      return AppStrings.emptyEmailAddress;
    } else if (!AppStrings.emailRegex.hasMatch(email.trim())) {
      return AppStrings.validateEmailAddress;
    }
    return null;
  }

  static String? validateFieldIsNotEmpty(
      {String? value, required String message}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? validateConfirmPassword({
    required String password,
    required String? confirmPassword,
  }) {
    if (confirmPassword == null || confirmPassword.trim().isEmpty) {
      return AppStrings.emptyConfirmPassword;
    }
    if (confirmPassword != password) {
      return AppStrings.passwordDontMatch;
    }
    return null;
  }
}
