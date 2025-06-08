import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens/config/theme/text_style.dart';
import 'package:trait_lens/core/utils/app_assets.dart';
import 'package:trait_lens/features/on_boarding/model/on_boarding_model.dart';
import 'package:trait_lens/features/on_boarding/view_model/on_boarding_view_model.dart';
import 'package:trait_lens/features/on_boarding/widgets/on_boarding_bottom_widget.dart';
import 'package:trait_lens/features/on_boarding/widgets/on_boarding_item_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppAssets.logo1, height: 32, width: 32),
            Text(
              'TraitLens',
              style: TextStyles.onBoardingTitle,
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        spacing: 24.h,
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: 3,
              controller: context.read<OnBoardingViewModel>().pageController,
              onPageChanged: (index) =>
                  context.read<OnBoardingViewModel>().setCurrentIndex(index),
              itemBuilder: (context, index) {
                return OnBoardingItemWidget(
                  onBoardingModel: OnBoardingModel.getOnboarding[index],
                );
              },
            ),
          ),
          const OnBoardingBottomWidget(),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
