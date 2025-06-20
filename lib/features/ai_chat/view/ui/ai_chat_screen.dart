import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trait_lens/core/di/di.dart';

import '../view_model/chat_screen_view_model.dart';
import '../widgets/chat_body_widget.dart';
import '../widgets/chat_screen_app_bar.dart';
import '../widgets/custom_chat_text_field.dart';

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
            ChatBodyWidget(viewModel: viewModel),
            FadeInUp(child: CustomChatTextField(viewModel: viewModel)),
          ],
        ),
      ),
    );
  }
}
