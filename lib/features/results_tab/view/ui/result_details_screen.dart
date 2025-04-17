import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens/config/theme/app_colors.dart';
import 'package:trait_lens/config/theme/text_style.dart';
import 'package:trait_lens/core/di/di.dart';
import 'package:trait_lens/features/ai_detection/data/models/detection_result_model.dart';

import 'package:trait_lens/features/ai_detection/view/widgets/detection_app_bar.dart';
import 'package:trait_lens/features/ai_detection/view/widgets/status_section.dart';
import 'package:trait_lens/features/results_tab/view/view_models/results_tab_view_model.dart';

class ResultDetailsScreen extends StatelessWidget {
  const ResultDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    final DetectionResultModel detectionResult =
        ModalRoute.of(context)!.settings.arguments as DetectionResultModel;

    final ResultsTabViewModel viewModel = getIt.get<ResultsTabViewModel>();

    return Scaffold(
      appBar: DetectionAppBar(title: locale!.results),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 45.w, vertical: 20.h),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SizedBox(
                  height: 250.h,
                  child: PieChart(
                    PieChartData(
                      sections: viewModel.getPieChartSections(
                        detectionResult.traits!,
                        radius: 50,
                        titleColor: ColorsManager.baseBlack,
                      ),
                      centerSpaceRadius: 50,
                      sectionsSpace: 2,
                      centerSpaceColor: Colors.white,
                      pieTouchData: PieTouchData(enabled: false),
                    ),
                  ),
                ),
                Text(
                  detectionResult.dominantTrait ?? '',
                  style: TextStyles.statusItemText,
                )
              ],
            ),
            SizedBox(height: 60.h),
            StatusSection(traits: detectionResult.traits),
          ],
        ),
      ),
    );
  }
}
