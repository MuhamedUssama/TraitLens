import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';
import '../view_model/profile_tab_actions.dart';
import '../view_model/profile_tab_view_model.dart';

class NotificationsWidget extends StatelessWidget {
  final ProfileTabViewModel viewModel;
  const NotificationsWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            locale!.notification,
            style: TextStyles.font14BlackRegular,
          ),
          ValueListenableBuilder(
            valueListenable: viewModel.switcher,
            builder: (context, switcher, child) {
              return Switch(
                value: switcher,
                onChanged: (value) {
                  viewModel.doIntent(NotificationSwitchAction());
                },
                activeColor: ColorsManager.white,
                activeTrackColor: ColorsManager.baseBlue,
                inactiveThumbColor: ColorsManager.white,
                inactiveTrackColor: ColorsManager.grey,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              );
            },
          ),
        ],
      ),
    );
  }
}
