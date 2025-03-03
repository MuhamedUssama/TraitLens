import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/app_assets.dart';

class ChatScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        children: [
          SvgPicture.asset(AppSvg.lensBot, width: 45.w),
          SizedBox(width: 20.w),
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
                  Text('Online', style: TextStyles.font18GreenMedium),
                ],
              ),
            ],
          ),
        ],
      ),
      shape: LinearBorder.bottom(
        side: const BorderSide(
          color: ColorsManager.floatingActionButtonColor,
        ),
      ),
      toolbarHeight: 70.h,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.h);
}
