import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens/core/di/di.dart';

import '../../../../config/routing/routes_name.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../view_models/text_view_model/text_detection_actions.dart';
import '../view_models/text_view_model/text_detection_states.dart';
import '../view_models/text_view_model/text_detection_view_model.dart';
import '../widgets/custom_submit_button.dart';
import '../widgets/detection_app_bar.dart';
import '../widgets/detection_header_section.dart';
import '../widgets/text_field_widget.dart';

class TextDetectionScreen extends StatelessWidget {
  TextDetectionScreen({super.key});

  final TextDetectionViewModel viewModel = getIt.get<TextDetectionViewModel>();

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    return Scaffold(
      appBar: DetectionAppBar(title: locale!.textScreen),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.w),
          child: BlocListener<TextDetectionViewModel, TextDetectionStates>(
            bloc: viewModel,
            listener: (context, state) {
              if (state is TextDetectionFailureState) {
                AppDialogs.showFailDialog(
                  message: state.exception ?? locale.somethingWentWrong,
                  context: context,
                  posActionTitle: locale.ok,
                );
              }
              if (state is TextDetectionSuccessState) {
                AppDialogs.showSuccessDialog(
                  message: locale.messageSuccessufflySent,
                  context: context,
                  posActionTitle: AppLocalizations.of(context)!.ok,
                  posAction: () {
                    // viewModel.doIntent(NavigateToAudioScreenAction());
                    Navigator.pushNamed(
                      context,
                      RoutesName.resultsScreenAfterDetection,
                      arguments: state.textModel,
                    );
                  },
                );
              }
              if (state is NavigateToAudioScreenState) {
                Navigator.pushNamed(context, RoutesName.voiceDetectionScreen);
              }
            },
            child: Column(
              children: [
                DetectionHeaderSection(title: locale.textScreenBody),
                SizedBox(height: 34.h),
                CustomTextField(viewModel: viewModel),
                SizedBox(height: 40.h),
                BlocBuilder<TextDetectionViewModel, TextDetectionStates>(
                  bloc: viewModel,
                  builder: (context, state) => CustomSubmitButton(
                    title: locale.submit,
                    isLoading: state is TextDetectionLoadingState,
                    onPressed: () {
                      viewModel.doIntent(SubmitClickAction());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
