import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens/features/ai_detection/view/widgets/custom_mic_button.dart';
import 'package:trait_lens/features/ai_detection/view/widgets/detection_app_bar.dart';
import 'package:trait_lens/features/ai_detection/view/widgets/detection_header_section.dart';
import 'package:trait_lens/features/ai_detection/view/widgets/wave_animation.dart';

class AudioDetectionScreen extends StatelessWidget {
  const AudioDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);
    bool isRecording = false;

    return Scaffold(
      appBar: DetectionAppBar(title: locale!.voiceScreen),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.w),
          child: Column(
            children: [
              DetectionHeaderSection(title: locale.voiceScreenBody),
              SizedBox(height: 24.h),
              Visibility(
                visible: isRecording,
                child: Column(
                  children: [
                    const WaveAnimation(),
                    SizedBox(height: 34.h),
                  ],
                ),
              ),
              CustomMicButton(
                isRecording: isRecording,
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
