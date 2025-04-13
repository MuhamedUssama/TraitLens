import '../../../data/models/text/text_detection_result_model.dart';

sealed class TextDetectionStates {}

class TextDetectionInitialState extends TextDetectionStates {}

class TextDetectionLoadingState extends TextDetectionStates {}

class TextDetectionFailureState extends TextDetectionStates {
  final String? exception;
  TextDetectionFailureState(this.exception);
}

class TextDetectionSuccessState extends TextDetectionStates {
  final DetectionResultModel? textModel;
  TextDetectionSuccessState(this.textModel);
}

class NavigateToAudioScreenState extends TextDetectionStates {}
