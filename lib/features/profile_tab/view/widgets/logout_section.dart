import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';

class LogoutSection extends StatelessWidget {
  const LogoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.logout,
                  color: ColorsManager.baseBlack,
                  size: 16,
                ),
                SizedBox(width: 4.w),
                Text(
                  locale!.logout,
                  style: TextStyles.font14BlackRegular,
                ),
              ],
            ),
            const Icon(
              Icons.logout,
              color: ColorsManager.baseBlue,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
