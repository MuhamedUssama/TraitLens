import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trait_lens/config/theme/text_style.dart';
import 'package:trait_lens/features/on_boarding/model/on_boarding_model.dart';

class OnBoardingItemWidget extends StatelessWidget {
  final OnBoardingModel onBoardingModel;

  const OnBoardingItemWidget({
    super.key,
    required this.onBoardingModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SvgPicture.asset(
              onBoardingModel.imagePath,
            ),
          ),
          Text(
            onBoardingModel.title,
            style: TextStyles.onBoardingTitle.copyWith(
              fontSize: 24.sp,
            ),
          ),
          Text(
            onBoardingModel.description,
            style: TextStyles.textFieldStyleChatScreen,
          ),
        ],
      ),
    );
  }
}
