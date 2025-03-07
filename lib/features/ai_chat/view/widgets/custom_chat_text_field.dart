import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trait_lens/config/theme/app_colors.dart';

import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/validation_utils.dart';
import '../view_model/chat_screen_view_model.dart';
import '../view_model/gemini_chat_actions.dart';

class CustomChatTextField extends StatelessWidget {
  final ChatScreenViewModel viewModel;
  const CustomChatTextField({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewModel.formKey,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextFormField(
          controller: viewModel.messageController,
          style: TextStyles.textFieldStyleChatScreen,
          cursorColor: ColorsManager.baseBlue,
          cursorRadius: const Radius.circular(10),
          decoration: InputDecoration(
            hintText: 'Write your message',
            hintStyle: TextStyles.textFieldHintTextChatScreen,
            suffixIcon: ValueListenableBuilder(
              valueListenable: viewModel.isTyping,
              builder: (context, value, child) => value
                  ? IconButton(
                      icon: SvgPicture.asset(AppSvg.stopCircle, width: 36.w),
                      onPressed: () {},
                    )
                  : IconButton(
                      icon: SvgPicture.asset(AppSvg.sendButton),
                      onPressed: () {
                        viewModel.doIntent(SendMessageAction());
                      },
                    ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30.r),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30.r),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) => AppValidator.validateFieldIsNotEmpty(
            message: '',
            value: value,
          ),
        ),
      ),
    );
  }
}
