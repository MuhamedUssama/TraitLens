import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/chat_screen_view_model.dart';
import '../view_model/gemini_chat_states.dart';
import 'empty_chat_widget.dart';
import 'message_widget.dart';

class ChatBodyWidget extends StatelessWidget {
  final ChatScreenViewModel viewModel;
  const ChatBodyWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatScreenViewModel, GeminiChatStates>(
      bloc: viewModel,
      builder: (context, state) {
        final messages = viewModel.messages;
        if (state is ChatWelcomeState && messages.isEmpty) {
          return EmptyChatWidget(viewModel: viewModel);
        }
        if (messages.isNotEmpty) {
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return Align(
                alignment: message.isUser
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: MessageWidget(message: message),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
