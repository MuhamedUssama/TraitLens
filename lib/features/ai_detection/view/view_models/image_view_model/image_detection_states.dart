import 'dart:io';
import 'package:trait_lens/features/ai_detection/data/models/detection_result_model.dart';

sealed class ImageDetectionStates {}

class ImageDetectionInitialState extends ImageDetectionStates {}

class ImageDetectionLoadingState extends ImageDetectionStates {}

class ImageDetectionSuccessState extends ImageDetectionStates {
  final DetectionResultModel? detectionResultModel;

  ImageDetectionSuccessState(this.detectionResultModel);
}

class ImageDetectionErrorState extends ImageDetectionStates {
  final String? error;

  ImageDetectionErrorState(this.error);
}

class ImageSelectedState extends ImageDetectionStates {
  final File imageFile;
  ImageSelectedState(this.imageFile);
}
