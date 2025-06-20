import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:trait_lens/features/ai_chat/view/ui/ai_chat_screen.dart';
import 'package:trait_lens/features/ai_detection/view/ui/audio_detection_screen.dart';
import 'package:trait_lens/features/ai_detection/view/ui/image_detection_screen.dart';
import 'package:trait_lens/features/ai_detection/view/ui/results_screen_after_detection.dart';
import 'package:trait_lens/features/ai_detection/view/ui/text_detection_screen.dart';
import 'package:trait_lens/features/auth/view/ui/forget_password_screen.dart';
import 'package:trait_lens/features/auth/view/ui/sign_in_screen.dart';
import 'package:trait_lens/features/auth/view/ui/sign_up_screen.dart';
import 'package:trait_lens/features/fill_profile/view/ui/fill_profile_screen.dart';
import 'package:trait_lens/features/home/view/ui/home_screen.dart';
import 'package:trait_lens/features/notifications/view/ui/notifications_screen.dart';
import 'package:trait_lens/features/on_boarding/on_boarding_screen.dart';
import 'package:trait_lens/features/on_boarding/view_model/on_boarding_view_model.dart';
import 'package:trait_lens/features/profile_tab/view/ui/edit_profile_screen.dart';
import 'package:trait_lens/features/results_tab/view/ui/result_details_screen.dart';

import 'routes_name.dart';

class AppRouters {
  static Route onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.onBoardingScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          child: BlocProvider(
            create: (context) => OnBoardingViewModel(),
            child: const OnBoardingScreen(),
          ),
        );

      case RoutesName.signUpScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          child: const SignUpScreen(),
        );

      case RoutesName.loginScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          child: const SignInScreen(),
        );

      case RoutesName.forgetPasswordScreen:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 500),
          settings: settings,
          child: const ForgetPasswordScreen(),
        );

      case RoutesName.fillProfileScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          child: const FillProfileScreen(),
        );

      case RoutesName.homeScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          child: HomeScreen(),
        );

      case RoutesName.editProfileScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          settings: settings,
          child: const EditProfileScreen(),
        );

      case RoutesName.chatAiScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          child: AiChatScreen(),
        );

      case RoutesName.textDetectionScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          settings: settings,
          child: TextDetectionScreen(),
        );

      case RoutesName.voiceDetectionScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          settings: settings,
          child: AudioDetectionScreen(),
        );

      case RoutesName.imageDetectionScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          settings: settings,
          child: ImageDetectionScreen(),
        );

      case RoutesName.resultsScreenAfterDetection:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          settings: settings,
          child: ResultsScreenAfterDetection(),
        );

      case RoutesName.notificationsScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          child: NotificationsScreen(),
        );

      case RoutesName.resultsScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          settings: settings,
          child: const ResultDetailsScreen(),
        );

      default:
        return MaterialPageRoute(builder: (context) => const SizedBox());
    }
  }
}
