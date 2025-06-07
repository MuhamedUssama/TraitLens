import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'config/routing/app_router.dart';
import 'config/routing/routes_name.dart';
import 'config/theme/app_theme.dart';
import 'core/di/di.dart';
import 'core/shared/language_view_model/language_states.dart';
import 'core/shared/language_view_model/language_view_model.dart';

class TraitLensApp extends StatelessWidget {
  const TraitLensApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider(
        create: (context) => getIt<LanguageViewModel>(),
        child: BlocBuilder<LanguageViewModel, LanguageStates>(
          builder: (context, state) {
            Locale currentLocale = const Locale('en');
            if (state is LanguageChangedState) {
              currentLocale = state.locale;
            }

            return MaterialApp(
              title: 'Trait Lens',
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              locale: currentLocale,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.appTheme,
              initialRoute: _getInitialRoute(),
              onGenerateRoute: (settings) => AppRouters.onGenerate(settings),
            );
          },
        ),
      ),
    );
  }

  String _getInitialRoute() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user != null ? RoutesName.homeScreen : RoutesName.loginScreen;
  }
}
