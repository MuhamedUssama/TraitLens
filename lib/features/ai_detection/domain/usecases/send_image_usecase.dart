import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/features/ai_detection/data/models/text/text_detection_result_model.dart';
import 'package:trait_lens/features/ai_detection/domain/repository/ai_detection_repository.dart';

@injectable
class SendImageUsecase {
  final AiDetectionRepository repository;

  @factoryMethod
  const SendImageUsecase(this.repository);

  Future<Either<ServerException, DetectionResultModel>> call({
    required File imageFile,
  }) async =>
      await repository.sendImage(imageFile: imageFile);
}
