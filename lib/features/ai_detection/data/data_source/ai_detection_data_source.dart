import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/features/ai_detection/data/models/detection_result_model.dart';

abstract interface class AiDetectionDataSource {
  Future<Either<ServerException, DetectionResultModel>> sendText({
    required String text,
  });

  Future<Either<ServerException, DetectionResultModel>> sendAudio({
    required File audioFile,
  });

  Future<Either<ServerException, DetectionResultModel>> sendImage({
    required File imageFile,
  });

  Future<Either<ServerException, DetectionResultModel>>
      uploadResultToFireStore({
    required DetectionResultModel detectionResult,
  });
}
