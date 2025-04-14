import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens/config/routing/routes_name.dart';
import 'package:trait_lens/core/di/di.dart';
import 'package:trait_lens/core/utils/app_dialogs.dart';
import 'package:trait_lens/features/ai_detection/data/models/detection_result_model.dart';
import 'package:trait_lens/features/ai_detection/view/view_models/audio_view_model/audio_detection_states.dart';
import 'package:trait_lens/features/ai_detection/view/view_models/audio_view_model/audio_detection_view_model.dart';
import 'package:trait_lens/features/ai_detection/view/widgets/custom_mic_button.dart';
import 'package:trait_lens/features/ai_detection/view/widgets/detection_app_bar.dart';
import 'package:trait_lens/features/ai_detection/view/widgets/detection_header_section.dart';
import 'package:trait_lens/features/ai_detection/view/widgets/wave_animation.dart';

class AudioDetectionScreen extends StatelessWidget {
  AudioDetectionScreen({super.key});

  final AudioDetectionViewModel viewModel =
      getIt.get<AudioDetectionViewModel>();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;

    final DetectionResultModel textResult =
        ModalRoute.of(context)!.settings.arguments as DetectionResultModel;

    return Scaffold(
      appBar: DetectionAppBar(title: locale.voiceScreen),
      body: SingleChildScrollView(
        child: BlocListener<AudioDetectionViewModel, AudioDetectionStates>(
          bloc: viewModel,
          listener: (context, state) {
            if (state is AudioDetectionLoadingState) {
              AppDialogs.showLoading(message: 'Loading..', context: context);
            }
            if (state is AudioDetectionErrorState) {
              AppDialogs.hideLoading(context);
              AppDialogs.showFailDialog(
                context: context,
                message: state.error ?? 'An error occurred',
                posActionTitle: locale.ok,
              );
            }
            if (state is AudioDetectionSuccessState) {
              AppDialogs.hideLoading(context);
              AppDialogs.showSuccessDialog(
                message: 'Audio sent successfully',
                context: context,
                posActionTitle: locale.ok,
                posAction: () {
                  Navigator.pushNamed(
                    context,
                    RoutesName.imageDetectionScreen,
                    arguments: {
                      'text': textResult,
                      'audio': state.detectionResultModel,
                    },
                  );
                },
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 36.w),
            child: Column(
              children: [
                DetectionHeaderSection(title: locale.voiceScreenBody),
                SizedBox(height: 24.h),
                BlocBuilder<AudioDetectionViewModel, AudioDetectionStates>(
                  bloc: viewModel,
                  builder: (context, state) {
                    bool isRecording = state is AudioDetectionRecordingState;

                    return Column(
                      children: [
                        if (isRecording)
                          FadeInUp(
                            duration: const Duration(milliseconds: 1200),
                            animate: true,
                            child: const WaveAnimation(),
                          ),
                        AnimatedPadding(
                          duration: const Duration(milliseconds: 1200),
                          curve: Curves.easeInOut,
                          padding: EdgeInsets.only(
                            top: isRecording ? 34.h : 100.h,
                          ),
                          child: CustomMicButton(
                            isRecording: isRecording,
                            onTap: () {
                              viewModel.recordAndSendAudio();
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
