import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens/config/theme/app_colors.dart';

class CustomResultCardSkeleton extends StatelessWidget {
  const CustomResultCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: ColorsManager.bottomNavigationBarColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: const BorderSide(color: ColorsManager.baseBlue),
      ),
      child: Container(
        height: 200.h,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 150.h,
              width: 150.w,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 16.h,
                  width: 100.w,
                  color: Colors.grey[300],
                ),
                Container(
                  height: 36.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
