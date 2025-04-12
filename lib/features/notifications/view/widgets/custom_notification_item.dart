import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trait_lens/config/theme/app_colors.dart';

class CustomNotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final String notificationId;

  const CustomNotificationItem(
      {super.key,
      required this.title,
      required this.message,
      required this.notificationId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Row(
        spacing: 12.w,
        children: [
          const Icon(
            Icons.notifications_active_rounded,
            color: ColorsManager.baseBlack,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  )
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: ColorsManager.baseBlack),
                ),
                SizedBox(height: 6.h),
                Text(
                  message,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: ColorsManager.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
