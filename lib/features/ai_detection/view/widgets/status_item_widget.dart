import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';

class StatusItemWidget extends StatelessWidget {
  final Color color;
  final String title;
  final String percentage;

  const StatusItemWidget({
    super.key,
    required this.color,
    required this.title,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: TextStyles.statusItemText,
          ),
          const Spacer(),
          Text(
            percentage,
            style:
                TextStyles.statusText.copyWith(color: ColorsManager.baseBlack),
          ),
        ],
      ),
    );
  }
}
