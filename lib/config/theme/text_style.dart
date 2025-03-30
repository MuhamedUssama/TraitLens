import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trait_lens/config/theme/app_colors.dart';

import 'font_weight_helper.dart';

class TextStyles {
  static TextStyle font16WhiteMedium = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.medium,
    color: Colors.white,
  );

  static TextStyle font20WhiteSemiBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: Colors.white,
  );

  static TextStyle font14BlackRegular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.baseBlack,
  );

  static TextStyle font16BlackRegular = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.baseBlack,
  );

  static TextStyle font18BlackMedium = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.baseBlack,
  );

  static TextStyle font20BlackBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.baseBlack,
  );

  static TextStyle font24BlackMedium = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.baseBlack,
  );

  static TextStyle font12GreyBold = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.grey,
  );

  static TextStyle font12GreyRegular = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w900,
    color: ColorsManager.grey,
  );

  static TextStyle font16DarkGreyMedium = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.secondaryColor,
  );

  static TextStyle font14GreySemiBold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: ColorsManager.secondaryColor,
  );

  static TextStyle font18GreyBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.secondaryColor,
  );

  static TextStyle font14GreyRegular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.secondaryColor,
  );

  static TextStyle font14BlueSemiBold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: ColorsManager.baseBlue,
  );

  static TextStyle font18BlueBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.baseBlue,
  );

  static TextStyle font24BlueBold = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.baseBlue,
  );

  static TextStyle chatScreenTitle = GoogleFonts.baloo2(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.baseBlue,
  );

  static TextStyle font30BlueBold = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w900,
    color: ColorsManager.baseBlue,
  );

  static TextStyle font12BlueRegular = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.baseBlue,
  );

  static TextStyle font32BlueBold = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.baseBlue,
  );

  static TextStyle font20GreyBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.secondaryColor,
  );

  static TextStyle font18GreenMedium = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.onlineColor,
  );

  static TextStyle chatScreenOnlie = GoogleFonts.baloo2(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.onlineColor,
  );

  static TextStyle noMessagesChat = GoogleFonts.baloo2(
    fontSize: 22.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.baseBlack,
  );

  static TextStyle textFieldHintTextChatScreen = GoogleFonts.nunito(
    color: const Color(0XFFA1A1A1),
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textFieldStyleChatScreen = GoogleFonts.nunito(
    color: ColorsManager.baseBlack,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle userMessageChatScreen = GoogleFonts.nunito(
    color: ColorsManager.white,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle aiMessageChatScreen = GoogleFonts.nunito(
    color: const Color(0XFF656565),
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle textMessageTextScreen = TextStyle(
    color: Colors.grey[600],
    fontSize: 16,
    fontFamily: 'Roboto',
  );

  static TextStyle statusText = TextStyle(
    color: const Color(0XFF737373),
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.medium,
    fontFamily: 'Roboto',
  );

  static TextStyle statusItemText = TextStyle(
    color: const Color(0XFF404040),
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    fontFamily: 'Roboto',
  );

  static TextStyle font12BlackMedium = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.baseBlack,
  );
}
