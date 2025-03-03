import '../../data/models/gemini_response_model.dart';

sealed class GeminiChatStates {}

class ChatInitialState extends GeminiChatStates {}

class SendMessageLoadingState extends GeminiChatStates {}

class SendMessageSuccessState extends GeminiChatStates {
  MessageModel? message;
  SendMessageSuccessState(this.message);
}

class SendMessageFailureState extends GeminiChatStates {
  String? errorMessage;
  SendMessageFailureState(this.errorMessage);
}

class NavigateToHomeScreenState extends GeminiChatStates {}
