import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/constants/end_points.dart';

import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/core/utils/firebase_services.dart';
import 'package:trait_lens/features/ai_detection/data/data_source/ai_detection_data_source.dart';
import 'package:trait_lens/features/ai_detection/data/models/detection_result_model.dart';

@LazySingleton(as: AiDetectionDataSource)
class AiDetectionDataSourceImpl implements AiDetectionDataSource {
  final Dio dio;

  AiDetectionDataSourceImpl(this.dio);

  @override
  Future<Either<ServerException, DetectionResultModel>> sendText({
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
        return Right(DetectionResultModel.fromJson(response.data));
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

  @override
  Future<Either<ServerException, DetectionResultModel>> sendAudio({
    required File audioFile,
  }) async {
    try {
      final FormData formData = FormData.fromMap({
        'audio_file': await MultipartFile.fromFile(
          audioFile.path,
          filename: audioFile.uri.pathSegments.last,
          contentType: MediaType('audio', 'wav'),
        ),
      });

      final response = await dio.post(
        EndPoints.audioEndPoint,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(DetectionResultModel.fromJson(response.data));
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

  String getImageMimeType(String filePath) {
    final String extension = filePath.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'bmp':
        return 'image/bmp';
      case 'webp':
        return 'image/webp';
      case 'tiff':
        return 'image/tiff';
      case 'svg':
        return 'image/svg+xml';
      case 'heic':
        return 'image/heic';
      case 'heif':
        return 'image/heif';
      case 'ico':
        return 'image/x-icon';
      case 'avif':
        return 'image/avif';
      case 'jfif':
        return 'image/jpeg';
      case 'exif':
        return 'image/exif';
      default:
        return 'application/octet-stream';
    }
  }

  @override
  Future<Either<ServerException, DetectionResultModel>> sendImage({
    required File imageFile,
  }) async {
    try {
      final String mimeType = getImageMimeType(imageFile.path);

      final FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.uri.pathSegments.last,
          contentType: MediaType.parse(mimeType),
        ),
      });

      final response = await dio.post(
        EndPoints.imageEndPoint,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(DetectionResultModel.fromJson(response.data));
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

  @override
  Future<Either<ServerException, DetectionResultModel>>
      uploadResultToFireStore({
    required DetectionResultModel detectionResult,
  }) async {
    try {
      final String userId = FirebaseAuth.instance.currentUser!.uid;

      log(detectionResult.toJson().toString());

      await FireBaseService.getUserReslutsCollection(userId)
          .add(detectionResult);

      return Right(detectionResult);
    } catch (error) {
      log(error.toString());
      return const Left(FetchDataException());
    }
  }
}
