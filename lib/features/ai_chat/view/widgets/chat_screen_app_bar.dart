import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/app_assets.dart';
import '../view_model/gemini_chat_actions.dart';
import '../view_model/gemini_chat_states.dart';
import '../view_model/chat_screen_view_model.dart';

class ChatScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideInDown(
      child: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Image.asset(AppAssets.logo, width: 45.w),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lens Bot', style: TextStyles.font24BlueBold),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorsManager.onlineColor,
                      radius: 3.w,
                    ),
                    SizedBox(width: 8.w),
                    Text('Online', style: TextStyles.chatScreenOnlie),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          BlocBuilder<ChatScreenViewModel, GeminiChatStates>(
            buildWhen: (previous, current) => current is VolumeButtonState,
            builder: (context, state) {
              final viewModel = context.read<ChatScreenViewModel>();
              return IconButton(
                onPressed: () {
                  viewModel.doIntent(VolumeButtonClickAction());
                },
                icon: viewModel.isVolumeOn
                    ? SvgPicture.asset(AppSvg.volumeOn,
                        height: 32.h, width: 32.w)
                    : SvgPicture.asset(
                        AppSvg.volumeOff,
                        height: 30.h,
                        width: 30.w,
                      ),
              );
            },
          ),
          SizedBox(width: 10.w),
        ],
        shape: LinearBorder.bottom(
          side: const BorderSide(
            color: ColorsManager.floatingActionButtonColor,
          ),
        ),
        toolbarHeight: 70.h,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.h);
}
