import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/animation_assets.dart';

class DetectionHeaderSection extends StatelessWidget {
  final String title;
  const DetectionHeaderSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: LottieBuilder.asset(
            AnimationsAssets.welcomeRobot,
            width: 200.w,
          ),
        ),
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              title,
              textStyle: TextStyles.font18GreyBold,
              textAlign: TextAlign.center,
              speed: const Duration(milliseconds: 100),
            ),
          ],
          totalRepeatCount: 1,
          pause: const Duration(milliseconds: 0),
        )
      ],
    );
  }
}
