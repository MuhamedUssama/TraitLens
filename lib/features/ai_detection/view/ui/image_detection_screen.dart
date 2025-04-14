import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens/config/routing/routes_name.dart';
import 'package:trait_lens/core/di/di.dart';
import 'package:trait_lens/core/utils/app_dialogs.dart';
import 'package:trait_lens/features/ai_detection/data/models/results_model.dart';
import 'package:trait_lens/features/ai_detection/data/models/text/text_detection_result_model.dart';
import 'package:trait_lens/features/ai_detection/view/view_models/image_view_model/image_detection_states.dart';
import 'package:trait_lens/features/ai_detection/view/view_models/image_view_model/image_detection_view_model.dart';
import 'package:trait_lens/features/ai_detection/view/widgets/custom_submit_button.dart';
import 'package:trait_lens/features/ai_detection/view/widgets/detection_app_bar.dart';
import 'package:trait_lens/features/ai_detection/view/widgets/detection_header_section.dart';
import 'package:trait_lens/features/ai_detection/view/widgets/take_image_from_user_widget.dart';

class ImageDetectionScreen extends StatelessWidget {
  ImageDetectionScreen({super.key});

  final ImageDetectionViewModel viewModel =
      getIt.get<ImageDetectionViewModel>();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;

    final Map<String, DetectionResultModel?> args = ModalRoute.of(context)!
        .settings
        .arguments as Map<String, DetectionResultModel?>;

    final DetectionResultModel textResult = args['text']!;
    final DetectionResultModel audioResult = args['audio']!;

    return Scaffold(
      appBar: DetectionAppBar(title: locale.imageScreen),
      body: BlocListener<ImageDetectionViewModel, ImageDetectionStates>(
        bloc: viewModel,
        listener: (context, state) {
          if (state is ImageDetectionSuccessState) {
            AppDialogs.showSuccessDialog(
              message: 'Image sent successfully',
              context: context,
              posActionTitle: locale.ok,
              posAction: () {
                Navigator.pushNamed(
                  context,
                  RoutesName.resultsScreenAfterDetection,
                  arguments: DetectionFlowResults(
                    textResult: textResult,
                    audioResult: audioResult,
                    imageResult: state.detectionResultModel!,
                  ),
                );
              },
            );
          }
          if (state is ImageDetectionErrorState) {
            AppDialogs.showFailDialog(
              context: context,
              message: state.error ?? 'An error occurred',
              posActionTitle: locale.ok,
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.w),
          child: Column(
            children: [
              DetectionHeaderSection(title: locale.imageScreenBody),
              SizedBox(height: 32.h),
              TakeImageFromUserWidget(viewModel: viewModel),
              SizedBox(height: 80.h),
              BlocBuilder<ImageDetectionViewModel, ImageDetectionStates>(
                bloc: viewModel,
                builder: (context, state) => CustomSubmitButton(
                  title: locale.showResults,
                  isLoading: state is ImageDetectionLoadingState,
                  onPressed: () {
                    viewModel.sendImage();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
