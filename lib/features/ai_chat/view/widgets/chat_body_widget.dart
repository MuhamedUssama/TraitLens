import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../config/theme/app_colors.dart';
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

        if (state is SendMessageLoadingState) {
          return ListView.builder(
            itemCount: messages.length + 1,
            itemBuilder: (context, index) {
              if (index == messages.length) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: _buildLoadingShimmer(context),
                );
              }
              return Align(
                alignment: messages[index].isUser
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: MessageWidget(message: messages[index]),
              );
            },
          );
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

  Widget _buildLoadingShimmer(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * .8,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 20.w,
      ),
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Color(0XFFEEEEEE),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.zero,
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Skeletonizer(
        enabled: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200.w,
              height: 10.h,
              color: ColorsManager.messageBackgroundColor,
            ),
            const SizedBox(height: 6),
            Container(
              width: 80.w,
              height: 10.h,
              color: ColorsManager.messageBackgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
