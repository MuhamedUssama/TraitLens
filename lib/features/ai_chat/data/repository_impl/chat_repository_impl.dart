import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/features/ai_chat/data/models/gemini_response_model.dart';

import '../../domain/repositoory/chat_repository.dart';
import '../data_source/chat_data_source.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final ChatDataSource _dataSource;

  @factoryMethod
  ChatRepositoryImpl(this._dataSource);

  Future<bool> _checkInternetConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    return (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
  }

  @override
  Future<Either<ServerException, MessageModel>> getGeminiResponse({
    String? message,
  }) async {
    if (await _checkInternetConnection()) {
      final either = await _dataSource.getGeminiResponse(message: message);

      return either.fold(
        (error) => Left(ServerException(error.message)),
        (responseMessage) => Right(responseMessage),
      );
    } else {
      return const Left(NoInternetConnectionException());
    }
  }
}
