import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'app_regex.dart';

class AppValidator {
  static String? validateEmailAddress(
      {String? email, required BuildContext context}) {
    if (email == null || email.trim().isEmpty) {
      return AppLocalizations.of(context)!.emptyEmailAddress;
    } else if (!AppRegex.emailRegex.hasMatch(email.trim())) {
      return AppLocalizations.of(context)!.validateEmailAddress;
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
    required BuildContext context,
  }) {
    if (confirmPassword == null || confirmPassword.trim().isEmpty) {
      return AppLocalizations.of(context)!.emptyConfirmPassword;
    }
    if (confirmPassword != password) {
      return AppLocalizations.of(context)!.passwordDontMatch;
    }
    return null;
  }
}
