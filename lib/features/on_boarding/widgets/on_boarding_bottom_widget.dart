import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens/config/routing/routes_name.dart';
import 'package:trait_lens/config/theme/app_colors.dart';
import 'package:trait_lens/core/cache/shared_preferences.dart';
import 'package:trait_lens/core/constants/app_constants.dart';
import 'package:trait_lens/features/on_boarding/model/on_boarding_model.dart';
import 'package:trait_lens/features/on_boarding/view_model/on_boarding_view_model.dart';

class OnBoardingBottomWidget extends StatelessWidget {
  const OnBoardingBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        context.read<OnBoardingViewModel>().currentPage != 0
            ? OutlinedButton(
                onPressed: () {
                  context.read<OnBoardingViewModel>().previousPage();
                },
                style: IconButton.styleFrom(
                  foregroundColor: ColorsManager.baseBlue,
                  backgroundColor: ColorsManager.white,
                  side: const BorderSide(color: ColorsManager.baseBlue),
                  shape: const CircleBorder(),
                ),
                child: const Icon(Icons.arrow_back),
              )
            : SizedBox(width: 56.w),
        DotsIndicator(
          dotsCount: OnBoardingModel.getOnboarding.length,
          position: context.watch<OnBoardingViewModel>().currentPage.toDouble(),
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () async {
            context.read<OnBoardingViewModel>().nextPage();
            if (context.read<OnBoardingViewModel>().currentPage == 1) {
              await SharedPreferencesHelper.saveData(
                key: AppConstants.onBoardingKey,
                value: true,
              );
            }

            // ignore: use_build_context_synchronously
            if (context.read<OnBoardingViewModel>().currentPage == 2) {
              Navigator.pushReplacementNamed(
                // ignore: use_build_context_synchronously
                context,
                RoutesName.loginScreen,
              );
            }
          },
          style: IconButton.styleFrom(
            foregroundColor: ColorsManager.baseBlue,
            backgroundColor: ColorsManager.white,
            side: const BorderSide(color: ColorsManager.baseBlue),
            shape: const CircleBorder(),
          ),
          child: const Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
