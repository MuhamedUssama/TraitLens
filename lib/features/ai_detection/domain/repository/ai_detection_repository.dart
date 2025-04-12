import 'package:dartz/dartz.dart';
import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/features/ai_detection/data/models/text/text_detection_result_model.dart';

abstract interface class AiDetectionRepository {
  Future<Either<ServerException, DetectionResultModel>> sendText({
    required String text,
  });
}
