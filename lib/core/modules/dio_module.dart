import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/constants/end_points.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio provideDio() {
    final dio = Dio();
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    return dio;
  }
}
