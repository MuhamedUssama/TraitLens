import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../core/utils/app_assets.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 60.w,
      decoration: BoxDecoration(
        color: ColorsManager.bottomNavigationBarColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Center(child: SvgPicture.asset(AppSvg.message, width: 32.w)),
    );
  }
}
