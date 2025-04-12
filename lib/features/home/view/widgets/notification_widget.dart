import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trait_lens/config/routing/routes_name.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../core/utils/app_assets.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: IconButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            RoutesName.notificationsScreen,
          );
        },
        icon: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            CircleAvatar(
              backgroundColor: ColorsManager.red,
              radius: 5.w,
            ),
            SvgPicture.asset(AppSvg.notification)
          ],
        ),
      ),
    );
  }
}
