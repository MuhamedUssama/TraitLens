import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomNotificationLoadingItem extends StatelessWidget {
  const CustomNotificationLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Skeletonizer(
        enabled: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey[300],
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150.w,
                    height: 14.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    width: double.infinity,
                    height: 12.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    width: 200.w,
                    height: 12.h,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
