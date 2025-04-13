import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.white,
    primaryColor: ColorsManager.baseBlue,
    textTheme: GoogleFonts.poppinsTextTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorsManager.transparent,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorsManager.baseBlue,
      selectionColor: ColorsManager.baseBlue.withValues(alpha: .5),
      selectionHandleColor: ColorsManager.baseBlue,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ColorsManager.baseBlue,
    ),
  );
}
