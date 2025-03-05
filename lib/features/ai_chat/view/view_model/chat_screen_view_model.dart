import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/gemini_response_model.dart';
import '../../domain/usecases/get_gemini_response.dart';
import 'gemini_chat_actions.dart';
import 'gemini_chat_states.dart';

@injectable
class ChatScreenViewModel extends Cubit<GeminiChatStates> {
  final GetGeminiResponse _geminiResponseUsecase;
  final FlutterTts flutterTts = FlutterTts();

  @factoryMethod
  ChatScreenViewModel(this._geminiResponseUsecase) : super(ChatInitialState()) {
    _initTts();
    _showWelcomeMessage();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController messageController = TextEditingController();
  List<MessageModel> messages = [];
  final String welcomeText = "Hi, I'm Lens Bot\nHow can I help you?";
  bool hasSpokenWelcome = false;

  Future<void> doIntent(GeminiChatActions actions) async {
    switch (actions) {
      case SendMessageAction():
        await _getGeminiResponse();
      case NavigateToHomeScreenAction():
        _navigateToHomeScreen();
    }
  }

  Future<void> _initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.5); // نغمة أعلى قليلاً
    await flutterTts.setSpeechRate(0.4);
    await flutterTts
        .setVoice({"name": "en-GB-SMTf00", "locale": "eng-x-lvariant-f00"});
  }

  Future<void> _showWelcomeMessage() async {
    if (messages.isEmpty && !hasSpokenWelcome) {
      await flutterTts.speak(welcomeText);
      hasSpokenWelcome = true;
      emit(ChatWelcomeState(welcomeText));
    }
  }

  Future<void> _getGeminiResponse() async {
    if (formKey.currentState!.validate()) {
      emit(SendMessageLoadingState());

      messages.add(MessageModel(text: messageController.text, isUser: true));

      final result = await _geminiResponseUsecase(
        message: messageController.text,
      );

      messageController.clear();

      result.fold(
        (error) => emit(SendMessageFailureState(error.message)),
        (messageResponse) {
          messages.add(messageResponse);
          emit(SendMessageSuccessState(messageResponse));
        },
      );
    }
  }

  void _navigateToHomeScreen() {
    emit(NavigateToHomeScreenState());
  }

  @override
  void onChange(Change<GeminiChatStates> change) {
    super.onChange(change);
  }

  @override
  Future<void> close() {
    flutterTts.stop();
    return super.close();
  }
}
