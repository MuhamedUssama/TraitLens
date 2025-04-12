import 'package:trait_lens/features/ai_detection/data/models/text/text_detection_result_model.dart';

sealed class AudioDetectionStates {}

class AudioDetectionInitialState extends AudioDetectionStates {}

class AudioDetectionLoadingState extends AudioDetectionStates {}

class AudioDetectionRecordingState extends AudioDetectionStates {}

class AudioDetectionSuccessState extends AudioDetectionStates {
  final DetectionResultModel? detectionResultModel;
  AudioDetectionSuccessState(this.detectionResultModel);
}

class AudioDetectionErrorState extends AudioDetectionStates {
  final String? error;

  AudioDetectionErrorState(this.error);
}

class AudioDetectionPermissionDeniedState extends AudioDetectionStates {
  final String errorMessage;
  AudioDetectionPermissionDeniedState(this.errorMessage);
}
