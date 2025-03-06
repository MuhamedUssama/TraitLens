import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../data/models/gemini_response_model.dart';
import '../repositoory/chat_repository.dart';

@injectable
class GetGeminiResponse {
  final ChatRepository _chatRepository;

  @factoryMethod
  GetGeminiResponse(this._chatRepository);

  Future<Either<ServerException, MessageModel>> call({String? message}) async {
    return await _chatRepository.getGeminiResponse(message: message);
  }
}
