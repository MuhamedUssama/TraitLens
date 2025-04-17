import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens/config/theme/app_colors.dart';
import 'package:trait_lens/config/theme/text_style.dart';
import 'package:trait_lens/features/ai_detection/data/models/traits_model.dart';
import 'package:trait_lens/features/results_tab/view/view_models/results_tab_view_model.dart';

class CustomResultCard extends StatelessWidget {
  final ResultsTabViewModel viewModel;
  final Traits traits;
  final String personalityType;

  const CustomResultCard({
    super.key,
    required this.viewModel,
    required this.traits,
    required this.personalityType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsManager.bottomNavigationBarColor,
        border: Border.all(color: ColorsManager.baseBlue),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.baseBlue.withValues(alpha: 0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SizedBox(
                height: 140.h,
                width: 140.w,
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
              Text(
                personalityType,
                style: TextStyles.statusItemText,
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {},
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
    );
  }
}
