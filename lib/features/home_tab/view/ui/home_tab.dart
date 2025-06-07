import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../config/routing/routes_name.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/animation_assets.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          Expanded(
            flex: 7,
            child: FadeIn(
              duration: const Duration(milliseconds: 800),
              child: LottieBuilder.asset(AnimationsAssets.welcomeRobot),
            ),
          ),
          FadeIn(
            delay: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 800),
            child: Text(
              locale!.homeTabBody,
              style: TextStyles.font18GreyBold,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 80.h),
          FadeInUp(
            child: CustomElevatedButton(
              title: locale.start,
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.textDetectionScreen);
              },
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
