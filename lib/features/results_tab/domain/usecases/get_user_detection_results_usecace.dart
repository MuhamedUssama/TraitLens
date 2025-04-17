import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/features/ai_detection/data/models/detection_result_model.dart';
import 'package:trait_lens/features/results_tab/domain/repository/results_tab_repository.dart';

@injectable
class GetUserDetectionResultsUsecace {
  final ResultsTabRepository _repository;

  @factoryMethod
  const GetUserDetectionResultsUsecace(this._repository);

  Future<Either<ServerException, List<DetectionResultModel>>> call() async {
    return await _repository.getUserResults();
  }
}
