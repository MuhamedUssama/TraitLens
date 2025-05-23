import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../data/models/gemini_response_model.dart';

abstract interface class ChatRepository {
  Future<Either<ServerException, MessageModel>> getGeminiResponse({
    String? message,
  });
}
