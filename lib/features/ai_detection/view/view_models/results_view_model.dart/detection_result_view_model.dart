import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/config/theme/app_colors.dart';
import 'package:trait_lens/config/theme/text_style.dart';
import 'package:trait_lens/features/ai_detection/data/models/detection_result_model.dart';
import 'package:trait_lens/features/ai_detection/data/models/traits_model.dart';
import 'package:trait_lens/features/ai_detection/domain/usecases/upload_detection_result_to_firestore_usecase.dart';

import 'detection_result_states.dart';

@injectable
class DetectionResultViewModel extends Cubit<DetectionResultStates> {
  final UploadDetectionResultToFirestoreUsecase _usecase;

  @factoryMethod
  DetectionResultViewModel(this._usecase)
      : super(DetectionResultInitialState());

  double parsePercentage(String? value) {
    if (value == null || value.isEmpty) return 0.0;
    return double.tryParse(value.replaceAll('%', '').trim()) ?? 0.0;
  }

  Traits calculateAverageTraits(List<Traits?> traitsList) {
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

  DetectionResultModel createResultModel(Traits traits) {
    final List<MapEntry<String, double>> traitValues = [
      MapEntry('Openness(O)', parsePercentage(traits.opennessO)),
      MapEntry(
          'Conscientiousness(C)', parsePercentage(traits.conscientiousnessC)),
      MapEntry('Extraversion(E)', parsePercentage(traits.extraversionE)),
      MapEntry('Agreeableness(A)', parsePercentage(traits.agreeablenessA)),
      MapEntry('Neuroticism(N)', parsePercentage(traits.neuroticismN)),
    ];

    final dominant = traitValues.reduce((a, b) => a.value > b.value ? a : b);

    return DetectionResultModel(
      dominantTrait: dominant.key,
      traits: traits,
    );
  }

  List<PieChartSectionData> getPieChartSections(Traits traits) {
    return [
      PieChartSectionData(
        color: ColorsManager.openness,
        value: parsePercentage(traits.opennessO),
        title: '${parsePercentage(traits.opennessO).toStringAsFixed(2)}%',
        radius: 50,
        titleStyle: TextStyles.font12BlackMedium,
      ),
      PieChartSectionData(
        color: ColorsManager.conscientiousness,
        value: parsePercentage(traits.conscientiousnessC),
        title:
            '${parsePercentage(traits.conscientiousnessC).toStringAsFixed(2)}%',
        radius: 50,
        titleStyle: TextStyles.font12BlackMedium,
      ),
      PieChartSectionData(
        color: ColorsManager.extraversion,
        value: parsePercentage(traits.extraversionE),
        title: '${parsePercentage(traits.extraversionE).toStringAsFixed(2)}%',
        radius: 50,
        titleStyle: TextStyles.font12BlackMedium,
      ),
      PieChartSectionData(
        color: ColorsManager.agreeableness,
        value: parsePercentage(traits.agreeablenessA),
        title: '${parsePercentage(traits.agreeablenessA).toStringAsFixed(2)}%',
        radius: 50,
        titleStyle: TextStyles.font12BlackMedium,
      ),
      PieChartSectionData(
        color: ColorsManager.neuroticism,
        value: parsePercentage(traits.neuroticismN),
        title: '${parsePercentage(traits.neuroticismN).toStringAsFixed(2)}%',
        radius: 50,
        titleStyle: TextStyles.font12BlackMedium,
      ),
    ];
  }

  Future<void> uploadDetectionResult(Traits model) async {
    emit(DetectionResultLoadingState());

    final DetectionResultModel detectionResult = createResultModel(model);

    final result = await _usecase(detectionResult: detectionResult);

    result.fold(
      (failure) => emit(DetectionResultErrorState(failure.message)),
      (success) => emit(DetectionResultSuccessState(success)),
    );
  }
}
