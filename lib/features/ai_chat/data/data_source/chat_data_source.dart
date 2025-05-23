import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/gemini_response_model.dart';

abstract interface class ChatDataSource {
  Future<Either<ServerException, MessageModel>> getGeminiResponse({
    String? message,
  });
}
