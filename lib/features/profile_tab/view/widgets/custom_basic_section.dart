import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';

class CustomBasicSection extends StatelessWidget {
  final String title;

  const CustomBasicSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyles.font14BlackRegular),
            const Icon(
              Icons.arrow_forward_ios,
              color: ColorsManager.darkGrey,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
