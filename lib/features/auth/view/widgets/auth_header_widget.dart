import 'package:flutter/material.dart';

class AuthHeaderWidget extends StatelessWidget {
  final String title;
  final String message;
  final TextStyle titleTextStyle;
  final TextStyle messageTextStyle;
  final double height;

  const AuthHeaderWidget({
    super.key,
    required this.title,
    required this.message,
    required this.titleTextStyle,
    required this.messageTextStyle,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: titleTextStyle,
        ),
        SizedBox(height: height),
        Text(
          message,
          style: messageTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
