import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';
import '../../data/models/gemini_response_model.dart';

class MessageWidget extends StatelessWidget {
  final MessageModel message;

  const MessageWidget({super.key, required this.message});

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
        color:
            message.isUser ? ColorsManager.baseBlue : const Color(0XFFEEEEEE),
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
      child: Text(
        message.text,
        style: message.isUser
            ? TextStyles.userMessageChatScreen
            : TextStyles.aiMessageChatScreen,
      ),
    );
  }
}
