import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens/config/theme/app_colors.dart';
import 'package:trait_lens/core/di/di.dart';

import '../view_model/chat_screen_view_model.dart';
import '../view_model/gemini_chat_states.dart';
import '../widgets/chat_screen_app_bar.dart';
import '../widgets/custom_chat_text_field.dart';
import '../widgets/empty_chat_widget.dart';

class AiChatScreen extends StatelessWidget {
  AiChatScreen({super.key});

  final ChatScreenViewModel viewModel = getIt.get<ChatScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: const ChatScreenAppBar(),
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            BlocBuilder<ChatScreenViewModel, GeminiChatStates>(
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
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 4.h, horizontal: 8.w),
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: message.isUser
                                ? ColorsManager.baseBlue
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color:
                                  message.isUser ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: CustomChatTextField(viewModel: viewModel),
            ),
          ],
        ),
      ),
    );
  }
}
