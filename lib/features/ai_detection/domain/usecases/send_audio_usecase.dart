import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/features/ai_detection/data/models/detection_result_model.dart';
import 'package:trait_lens/features/ai_detection/domain/repository/ai_detection_repository.dart';

@injectable
class SendAudioUsecase {
  final AiDetectionRepository _detectionRepository;

  @factoryMethod
  const SendAudioUsecase(this._detectionRepository);

  Future<Either<ServerException, DetectionResultModel>> call({
    required File audioFile,
  }) =>
      _detectionRepository.sendAudio(audioFile: audioFile);
}
