import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthHeaderWidget extends StatelessWidget {
  final String title;
  final String message;
  final TextStyle titleTextStyle;
  final TextStyle messageTextStyle;
  const AuthHeaderWidget({
    super.key,
    required this.title,
    required this.message,
    required this.titleTextStyle,
    required this.messageTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: titleTextStyle,
        ),
        SizedBox(height: 6.h),
        Text(
          message,
          style: messageTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
