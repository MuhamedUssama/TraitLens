import 'package:flutter/material.dart';

import '../widgets/chat_screen_app_bar.dart';

class AiChatScreen extends StatelessWidget {
  const AiChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ChatScreenAppBar(),
    );
  }
}
