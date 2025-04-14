import 'text/text_detection_result_model.dart';

class DetectionFlowResults {
  final DetectionResultModel textResult;
  final DetectionResultModel audioResult;
  final DetectionResultModel imageResult;

  DetectionFlowResults({
    required this.textResult,
    required this.audioResult,
    required this.imageResult,
  });
}
