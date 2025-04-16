import 'package:trait_lens/features/ai_detection/data/models/detection_result_model.dart';

sealed class DetectionResultStates {}

class DetectionResultInitialState extends DetectionResultStates {}

class DetectionResultLoadingState extends DetectionResultStates {}

class DetectionResultSuccessState extends DetectionResultStates {
  final DetectionResultModel? detectionResultModel;
  DetectionResultSuccessState(this.detectionResultModel);
}

class DetectionResultErrorState extends DetectionResultStates {
  final String? message;
  DetectionResultErrorState(this.message);
}
