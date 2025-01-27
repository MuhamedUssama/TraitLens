import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/theme/app_theme.dart';

class TraitLensApp extends StatelessWidget {
  const TraitLensApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Trait Lens',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        home: Scaffold(),
      ),
    );
  }
}
