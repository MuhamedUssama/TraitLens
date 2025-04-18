import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:trait_lens/config/theme/app_colors.dart';
import 'package:trait_lens/core/di/di.dart';
import 'package:trait_lens/core/utils/animation_assets.dart';
import 'package:trait_lens/features/results_tab/view/view_models/results_tab_states.dart';
import 'package:trait_lens/features/results_tab/view/view_models/results_tab_view_model.dart';
import 'package:trait_lens/features/results_tab/view/widgets/custom_result_card.dart';
import 'package:trait_lens/features/results_tab/view/widgets/cutom_result_card_skeleton.dart';

class ResultsTab extends StatelessWidget {
  ResultsTab({super.key});

  final ResultsTabViewModel viewModel = getIt.get<ResultsTabViewModel>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ResultsTabViewModel, ResultsTabStates>(
          bloc: viewModel,
          builder: (context, state) {
            if (state is ResultTabsLoadingState) {
              return Expanded(
                child: Skeletonizer(
                  enabled: true,
                  child: ListView.separated(
                    itemCount: 3,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                    itemBuilder: (context, index) {
                      return const CustomResultCardSkeleton();
                    },
                  ),
                ),
              );
            } else if (state is ResultTabsErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: ColorsManager.red),
                ),
              );
            } else if (state is ResultTabsEmptyListState) {
              return Expanded(
                child: FadeIn(
                  child: LottieBuilder.asset(AnimationsAssets.emptyList),
                ),
              );
            } else if (state is ResultTabsLoadedState) {
              return Expanded(
                child: ListView.separated(
                  itemCount: state.results.length,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16.h);
                  },
                  itemBuilder: (context, index) {
                    return FadeInLeft(
                      delay: Duration(milliseconds: 100 * index),
                      child: CustomResultCard(
                        viewModel: viewModel,
                        detectionResul: state.results[index],
                      ),
                    );
                  },
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
