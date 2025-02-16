import 'package:flutter/material.dart';
import 'package:trait_lens/features/auth/view/ui/forget_password_screen.dart';
import 'package:trait_lens/features/auth/view/ui/sign_in_screen.dart';
import 'package:trait_lens/features/auth/view/ui/sign_up_screen.dart';
import 'package:trait_lens/features/home/view/ui/home_screen.dart';

import 'routes_name.dart';

class AppRouters {
  static Route onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.signUpScreen:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());

      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (context) => const SignInScreen());

      case RoutesName.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => const ForgetPasswordScreen(),
        );

      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      default:
        return MaterialPageRoute(builder: (context) => unDefinePageRoute());
    }
  }

  static Widget unDefinePageRoute() {
    return const Scaffold(
      body: Center(
        child: Text("Un Defined PageRoute"),
      ),
    );
  }
}
