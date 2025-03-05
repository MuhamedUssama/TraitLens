import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:trait_lens/config/theme/app_colors.dart';
import 'package:trait_lens/core/di/di.dart';

import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/animation_assets.dart';
import '../view_model/chat_screen_view_model.dart';
import '../view_model/gemini_chat_actions.dart';
import '../view_model/gemini_chat_states.dart';
import '../widgets/chat_screen_app_bar.dart';

class AiChatScreen extends StatelessWidget {
  AiChatScreen({super.key});

  final ChatScreenViewModel viewModel = getIt.get<ChatScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: const ChatScreenAppBar(),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatScreenViewModel, GeminiChatStates>(
                bloc: viewModel,
                builder: (context, state) {
                  final messages = viewModel.messages;

                  if (state is ChatWelcomeState && messages.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LottieBuilder.asset(
                            AnimationsAssets.welcomeRobot,
                            width: MediaQuery.sizeOf(context).width * .6,
                          ),
                          AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                state.welcomeText,
                                textStyle: TextStyles.noMessagesChat,
                                textAlign: TextAlign.center,
                                speed: const Duration(milliseconds: 102),
                              ),
                            ],
                            totalRepeatCount: 1,
                          ),
                        ],
                      ),
                    );
                  }

                  // عرض قائمة الرسائل إذا كانت موجودة
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
                                color: message.isUser
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  // حالة افتراضية (قد تكون فارغة أو تحميل)
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Form(
                key: viewModel.formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: viewModel.messageController,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a message';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 8.w),
                    IconButton(
                      icon:
                          const Icon(Icons.send, color: ColorsManager.baseBlue),
                      onPressed: () {
                        viewModel.doIntent(SendMessageAction());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
