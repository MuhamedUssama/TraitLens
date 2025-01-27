import 'package:flutter/material.dart';

import 'animation_assets.dart';
import 'app_dialog_utils.dart';

class AppDialogs {
  static void showFailDialog(
      {required String message,
      required BuildContext context,
      String? posActionTitle,
      VoidCallback? posAction,
      String? negativeActionTitle,
      VoidCallback? negativeAction}) {
    AppDialogUtils.showDialogOnScreen(
      context: context,
      message: message,
      imagePath: AnimationsAssets.errorAnimation,
      posAction: posAction,
      negativeAction: negativeAction,
      negativeActionTitle: negativeActionTitle,
      posActionTitle: posActionTitle,
    );
  }

  static void showInfoDialog(
      {required String message,
      required BuildContext context,
      String? posActionTitle,
      VoidCallback? posAction,
      String? negativeActionTitle,
      VoidCallback? negativeAction}) {
    AppDialogUtils.showDialogOnScreen(
      context: context,
      message: message,
      imagePath: AnimationsAssets.infoAnimation,
      posAction: posAction,
      negativeAction: negativeAction,
      negativeActionTitle: negativeActionTitle,
      posActionTitle: posActionTitle,
    );
  }

  static void showLoading(
      {required String message, required BuildContext context}) {
    AppDialogUtils.showLoadingDialog(context: context, message: message);
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showSuccessDialog(
      {required String message,
      required BuildContext context,
      String? posActionTitle,
      VoidCallback? posAction,
      String? negativeActionTitle,
      VoidCallback? negativeAction}) {
    AppDialogUtils.showDialogOnScreen(
      context: context,
      message: message,
      imagePath: AnimationsAssets.checkAnimation,
      posAction: posAction,
      negativeAction: negativeAction,
      negativeActionTitle: negativeActionTitle,
      posActionTitle: posActionTitle,
    );
  }
}
