import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_gemini_response.dart';
import 'gemini_chat_actions.dart';
import 'gemini_chat_states.dart';

@injectable
class ChatScreenViewModel extends Cubit<GeminiChatStates> {
  final GetGeminiResponse _geminiResponseUsecase;

  @factoryMethod
  ChatScreenViewModel(this._geminiResponseUsecase) : super(ChatInitialState());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController messageController = TextEditingController();

  Future<void> doIntent(GeminiChatActions actions) async {
    switch (actions) {
      case SendMessageAction():
        await _getGeminiResponse();
      case NavigateToHomeScreenAction():
        _navigateToHomeScreen();
    }
  }

  Future<void> _getGeminiResponse() async {
    if (formKey.currentState!.validate()) {
      emit(SendMessageLoadingState());

      final result = await _geminiResponseUsecase(
        message: messageController.text,
      );

      result.fold(
        (error) => emit(SendMessageFailureState(error.message)),
        (messageResponse) => emit(SendMessageSuccessState(messageResponse)),
      );
    }
  }

  void _navigateToHomeScreen() {
    emit(NavigateToHomeScreenState());
  }
}
