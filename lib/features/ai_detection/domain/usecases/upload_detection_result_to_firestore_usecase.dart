import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/features/ai_detection/data/models/detection_result_model.dart';

import '../repository/ai_detection_repository.dart';

@injectable
class UploadDetectionResultToFirestoreUsecase {
  final AiDetectionRepository _repository;
  @factoryMethod
  const UploadDetectionResultToFirestoreUsecase(this._repository);

  Future<Either<ServerException, DetectionResultModel>> call({
    required DetectionResultModel detectionResult,
  }) async {
    return await _repository.uploadResultToFireStore(
      detectionResult: detectionResult,
    );
  }
}
