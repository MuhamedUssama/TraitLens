import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trait_lens/core/di/di.dart';
import 'package:trait_lens/core/utils/app_dialogs.dart';
import 'package:trait_lens/features/ai_detection/data/models/results_model.dart';
import 'package:trait_lens/features/ai_detection/view/view_models/results_view_model.dart/detection_result_view_model.dart';

import '../../data/models/traits_model.dart';
import '../view_models/results_view_model.dart/detection_result_states.dart';
import '../widgets/custom_submit_button.dart';
import '../widgets/detection_app_bar.dart';
import '../widgets/status_section.dart';

class ResultsScreenAfterDetection extends StatelessWidget {
  ResultsScreenAfterDetection({super.key});

  final DetectionResultViewModel viewModel =
      getIt.get<DetectionResultViewModel>();

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    final DetectionFlowResults arguments =
        ModalRoute.of(context)!.settings.arguments as DetectionFlowResults;

    final Traits traits = viewModel.calculateAverageTraits([
      arguments.textResult.traits,
      arguments.audioResult.traits,
      arguments.imageResult.traits,
    ]);

    return Scaffold(
      appBar: DetectionAppBar(title: locale!.results),
      body: BlocListener<DetectionResultViewModel, DetectionResultStates>(
        bloc: viewModel,
        listener: (context, state) {
          if (state is DetectionResultSuccessState) {
            AppDialogs.showSuccessDialog(
              message: 'Data of detection result uploaded successfully',
              context: context,
              posActionTitle: locale.ok,
              posAction: () {},
            );
          }
          if (state is DetectionResultErrorState) {
            AppDialogs.showFailDialog(
              context: context,
              message: state.message ?? 'An error occurred',
              posActionTitle: locale.ok,
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 250.h,
                      child: PieChart(
                        PieChartData(
                          sections: viewModel.getPieChartSections(traits),
                          centerSpaceRadius: 50,
                          sectionsSpace: 2,
                          centerSpaceColor: Colors.white,
                          pieTouchData: PieTouchData(enabled: false),
                        ),
                      ),
                    ),
                    SizedBox(height: 60.h),
                    StatusSection(traits: traits),
                  ],
                ),
              ),
              SizedBox(height: 100.h),
              BlocBuilder<DetectionResultViewModel, DetectionResultStates>(
                bloc: viewModel,
                builder: (context, state) {
                  return CustomSubmitButton(
                    title: locale.finish,
                    isLoading: state is DetectionResultLoadingState,
                    onPressed: () {
                      viewModel.uploadDetectionResult(traits);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
