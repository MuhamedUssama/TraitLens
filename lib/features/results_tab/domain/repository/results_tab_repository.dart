import 'package:dartz/dartz.dart';
import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/features/ai_detection/data/models/detection_result_model.dart';

abstract interface class ResultsTabRepository {
  Future<Either<ServerException, DetectionResultModel>> getUserResults();
}
