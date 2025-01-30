import 'package:flutter/material.dart';
import 'package:trait_lens/features/auth/sign_up/view/sign_up_screen.dart';

import 'routes_name.dart';

class AppRouters {
  static Route onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.signUpScreen:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());

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
