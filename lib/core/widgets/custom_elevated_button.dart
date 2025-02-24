import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/text_style.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function onPressed;
  final String title;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 60.h),
        backgroundColor: ColorsManager.baseBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Text(title, style: TextStyles.font20WhiteSemiBold),
    );
  }
}
