import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trait_lens/features/ai_detection/data/models/results_model.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';
import '../../data/models/traits_model.dart';
import '../widgets/custom_submit_button.dart';
import '../widgets/detection_app_bar.dart';
import '../widgets/status_section.dart';

class ResultsScreenAfterDetection extends StatelessWidget {
  const ResultsScreenAfterDetection({super.key});

  double _parsePercentage(String? value) {
    if (value == null) return 0.0;
    return double.tryParse(value.replaceAll('%', '')) ?? 0.0;
  }

  Traits _calculateAverageTraits(List<Traits?> traitsList) {
    double avg(double Function(Traits t) extractor) {
      final valid = traitsList.whereType<Traits>().toList();
      if (valid.isEmpty) return 0.0;
      return valid.map(extractor).reduce((a, b) => a + b) / valid.length;
    }

    return Traits(
      opennessO:
          '${avg((t) => double.parse(t.opennessO?.replaceAll('%', '') ?? '0')).toStringAsFixed(2)}%',
      conscientiousnessC:
          '${avg((t) => double.parse(t.conscientiousnessC?.replaceAll('%', '') ?? '0')).toStringAsFixed(2)}%',
      extraversionE:
          '${avg((t) => double.parse(t.extraversionE?.replaceAll('%', '') ?? '0')).toStringAsFixed(2)}%',
      agreeablenessA:
          '${avg((t) => double.parse(t.agreeablenessA?.replaceAll('%', '') ?? '0')).toStringAsFixed(2)}%',
      neuroticismN:
          '${avg((t) => double.parse(t.neuroticismN?.replaceAll('%', '') ?? '0')).toStringAsFixed(2)}%',
    );
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    final DetectionFlowResults arguments =
        ModalRoute.of(context)!.settings.arguments as DetectionFlowResults;

    final Traits traits = _calculateAverageTraits([
      arguments.textResult.traits,
      arguments.audioResult.traits,
      arguments.imageResult.traits,
    ]);

    final List<PieChartSectionData> pieChartSections = [
      PieChartSectionData(
        color: ColorsManager.openness,
        value: _parsePercentage(traits.opennessO),
        title: '${_parsePercentage(traits.opennessO).toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyles.font12BlackMedium,
      ),
      PieChartSectionData(
        color: ColorsManager.conscientiousness,
        value: _parsePercentage(traits.conscientiousnessC),
        title:
            '${_parsePercentage(traits.conscientiousnessC).toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyles.font12BlackMedium,
      ),
      PieChartSectionData(
        color: ColorsManager.extraversion,
        value: _parsePercentage(traits.extraversionE),
        title: '${_parsePercentage(traits.extraversionE).toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyles.font12BlackMedium,
      ),
      PieChartSectionData(
        color: ColorsManager.agreeableness,
        value: _parsePercentage(traits.agreeablenessA),
        title: '${_parsePercentage(traits.agreeablenessA).toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyles.font12BlackMedium,
      ),
      PieChartSectionData(
        color: ColorsManager.neuroticism,
        value: _parsePercentage(traits.neuroticismN),
        title: '${_parsePercentage(traits.neuroticismN).toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyles.font12BlackMedium,
      ),
    ];

    return Scaffold(
      appBar: DetectionAppBar(title: locale!.results),
      body: SingleChildScrollView(
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
                        sections: pieChartSections,
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
            CustomSubmitButton(
              title: locale.finish,
              isLoading: false,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
