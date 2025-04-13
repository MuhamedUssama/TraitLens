import 'package:animate_do/animate_do.dart';
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
        FadeIn(
          animate: true,
          duration: const Duration(milliseconds: 800),
          child: Text(
            title,
            style: TextStyles.font18GreyBold,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
