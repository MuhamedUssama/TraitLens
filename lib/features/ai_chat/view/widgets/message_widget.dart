import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';
import '../../data/models/gemini_response_model.dart';
import '../view_model/chat_screen_view_model.dart';

class MessageWidget extends StatelessWidget {
  final ChatScreenViewModel viewModel;
  final MessageModel message;

  const MessageWidget(
      {super.key, required this.message, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * .8,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 20.w,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: message.isUser
            ? ColorsManager.baseBlue
            : ColorsManager.messageBackgroundColor,
        borderRadius: message.isUser
            ? BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
                topLeft: Radius.circular(20.r),
                topRight: Radius.zero,
              )
            : BorderRadius.only(
                bottomLeft: Radius.zero,
                bottomRight: Radius.circular(20.r),
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
      ),
      child: message.isUser
          ? Text(
              message.text,
              style: TextStyles.userMessageChatScreen,
            )
          : AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  message.text,
                  textStyle: TextStyles.aiMessageChatScreen,
                  speed: const Duration(milliseconds: 50),
                  cursor: '',
                  textAlign: TextAlign.start,
                ),
              ],
              onFinished: () => viewModel.isTyping.value = false,
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 0),
            ),
    );
  }
}
