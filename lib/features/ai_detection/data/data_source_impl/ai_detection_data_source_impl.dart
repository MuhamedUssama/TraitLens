import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/constants/end_points.dart';

import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/features/ai_detection/data/data_source/ai_detection_data_source.dart';
import 'package:trait_lens/features/ai_detection/data/models/text/text_detection_result_model.dart';

@LazySingleton(as: AiDetectionDataSource)
class AiDetectionDataSourceImpl implements AiDetectionDataSource {
  final Dio dio;

  AiDetectionDataSourceImpl(this.dio);

  @override
  Future<Either<ServerException, TextDetectionResultModel>> sendText({
    required String text,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.textEndPoint,
        data: {'text': text},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(TextDetectionResultModel.fromJson(response.data));
      } else {
        return Left(_handleStatusCode(response.statusCode));
      }
    } on DioException catch (exception) {
      if (exception.type == DioExceptionType.connectionTimeout ||
          exception.type == DioExceptionType.receiveTimeout ||
          exception.type == DioExceptionType.sendTimeout) {
        return const Left(NoInternetConnectionException());
      } else if (exception.response != null) {
        return Left(_handleStatusCode(exception.response!.statusCode));
      } else {
        return const Left(FetchDataException());
      }
    } catch (error) {
      return const Left(InternalServerErrorException());
    }
  }

  ServerException _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return const BadRequestException();
      case 401:
        return const UnauthorizedException();
      case 404:
        return const NotFoundException();
      case 409:
        return const ConflictException();
      case 500:
        return const InternalServerErrorException();
      default:
        return const FetchDataException();
    }
  }
}
