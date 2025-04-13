import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trait_lens/core/utils/app_assets.dart';
import 'package:trait_lens/features/ai_detection/view/widgets/detection_app_bar.dart';
import 'package:trait_lens/features/ai_detection/view/widgets/detection_header_section.dart';
import 'package:trait_lens/features/ai_detection/view/widgets/wave_animation.dart';

class AudioDetectionScreen extends StatelessWidget {
  const AudioDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    return Scaffold(
      appBar: DetectionAppBar(title: locale!.voiceScreen),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.w),
          child: Column(
            children: [
              DetectionHeaderSection(title: locale.voiceScreenBody),
              SizedBox(height: 24.h),
              const WaveAnimation(),
              SizedBox(height: 34.h),
            ],
          ),
        ),
      ),
    );
  }
}
