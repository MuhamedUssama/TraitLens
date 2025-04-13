import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/helpers/connectivity_helper.dart';
import '../../domain/repository/ai_detection_repository.dart';
import '../data_source/ai_detection_data_source.dart';
import '../models/text/text_detection_result_model.dart';

@Injectable(as: AiDetectionRepository)
class AiDetectionRepositoryImpl implements AiDetectionRepository {
  final AiDetectionDataSource _dataSource;

  @factoryMethod
  AiDetectionRepositoryImpl(this._dataSource);

  @override
  Future<Either<ServerException, DetectionResultModel>> sendText({
    required String text,
  }) async {
    if (await ConnectivityHelper.checkInternetConnection()) {
      final either = await _dataSource.sendText(text: text);

      return either.fold(
        (error) => Left(ServerException(error.message)),
        (result) => Right(result),
      );
    } else {
      return const Left(NoInternetConnectionException());
    }
  }

  @override
  Future<Either<ServerException, DetectionResultModel>> sendAudio(
      {required File audioFile}) async {
    if (await ConnectivityHelper.checkInternetConnection()) {
      final either = await _dataSource.sendAudio(audioFile: audioFile);

      return either.fold(
        (error) => Left(ServerException(error.message)),
        (result) => Right(result),
      );
    } else {
      return const Left(NoInternetConnectionException());
    }
  }

  @override
  Future<Either<ServerException, DetectionResultModel>> sendImage(
      {required File imageFile}) async {
    if (await ConnectivityHelper.checkInternetConnection()) {
      final either = await _dataSource.sendImage(imageFile: imageFile);

      return either.fold(
        (error) => Left(ServerException(error.message)),
        (result) => Right(result),
      );
    } else {
      return const Left(NoInternetConnectionException());
    }
  }
}
