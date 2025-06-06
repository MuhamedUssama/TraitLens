import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../data/models/detection_result_model.dart';
import '../repository/ai_detection_repository.dart';

@injectable
class SendTextUsecase {
  final AiDetectionRepository _detectionRepository;

  @factoryMethod
  SendTextUsecase(this._detectionRepository);

  Future<Either<ServerException, DetectionResultModel>> call({
    required String text,
  }) {
    return _detectionRepository.sendText(text: text);
  }
}
