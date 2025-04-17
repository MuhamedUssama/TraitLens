import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens/config/routing/routes_name.dart';
import 'package:trait_lens/config/theme/app_colors.dart';
import 'package:trait_lens/config/theme/text_style.dart';
import 'package:trait_lens/features/ai_detection/data/models/detection_result_model.dart';
import 'package:trait_lens/features/results_tab/view/view_models/results_tab_view_model.dart';

class CustomResultCard extends StatelessWidget {
  final ResultsTabViewModel viewModel;
  final DetectionResultModel detectionResul;

  const CustomResultCard({
    super.key,
    required this.viewModel,
    required this.detectionResul,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: ColorsManager.bottomNavigationBarColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: const BorderSide(color: ColorsManager.baseBlue),
      ),
      child: Container(
        height: 200.h,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SizedBox(
                  height: 150.h,
                  width: 150.w,
                  child: PieChart(
                    PieChartData(
                      sections:
                          viewModel.getPieChartSections(detectionResul.traits!),
                      centerSpaceRadius: 55,
                      sectionsSpace: 2,
                      centerSpaceColor: Colors.white,
                      pieTouchData: PieTouchData(enabled: false),
                    ),
                  ),
                ),
                Text(
                  'Total Value',
                  style: TextStyles.font16GreyBold,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  detectionResul.dominantTrait ?? '',
                  style: TextStyles.font16GreyBold,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.resultsScreen,
                      arguments: detectionResul,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.baseBlue,
                    foregroundColor: ColorsManager.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Show Details',
                    style: TextStyles.text14WhiteMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
