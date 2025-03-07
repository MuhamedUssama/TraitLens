import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/animation_assets.dart';
import '../view_model/chat_screen_view_model.dart';

class EmptyChatWidget extends StatelessWidget {
  final ChatScreenViewModel viewModel;

  const EmptyChatWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            AnimationsAssets.welcomeRobot,
            width: MediaQuery.sizeOf(context).width * .6,
          ),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                viewModel.welcomeText,
                textStyle: TextStyles.noMessagesChat,
                textAlign: TextAlign.center,
                speed: const Duration(milliseconds: 102),
              ),
            ],
            totalRepeatCount: 1,
          ),
        ],
      ),
    );
  }
}
