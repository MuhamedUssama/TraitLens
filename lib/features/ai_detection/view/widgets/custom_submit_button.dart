import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';

class CustomSubmitButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final bool isLoading;

  const CustomSubmitButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.isLoading,
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
      child: isLoading
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.white,
                size: 40,
              ),
            )
          : Text(title, style: TextStyles.font20WhiteSemiBold),
    );
  }
}
