import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../config/theme/app_colors.dart';
import '../view_model/home_screen_view_model.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final HomeScreenViewModel viewModel;
  final List<SalomonBottomBarItem> items;

  const CustomBottomNavigationBar({
    super.key,
    required this.viewModel,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: ColorsManager.bottomNavigationBarColor,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color:
                ColorsManager.bottomNavigationBarColor.withValues(alpha: 0.3),
            offset: const Offset(0, 20),
            blurRadius: 20,
          ),
        ],
      ),
      child: SalomonBottomBar(
        items: items,
        currentIndex: viewModel.currentIndex,
        unselectedItemColor: ColorsManager.secondaryColor,
        onTap: (index) => viewModel.onTabClicked(index),
      ),
    );
  }
}
