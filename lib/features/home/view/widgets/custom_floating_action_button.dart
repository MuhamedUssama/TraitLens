import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/routing/routes_name.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/utils/app_assets.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, RoutesName.chatAiScreen);
      },
      backgroundColor: ColorsManager.bottomNavigationBarColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: SvgPicture.asset(AppSvg.message, width: 32.w),
    );
  }
}
