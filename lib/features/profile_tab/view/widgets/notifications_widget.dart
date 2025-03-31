import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens/core/di/di.dart';
import 'package:trait_lens/core/shared/notifications_view_model/notifications_states.dart';
import 'package:trait_lens/core/shared/notifications_view_model/notifications_view_model.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';

class NotificationsWidget extends StatelessWidget {
  NotificationsWidget({super.key});

  final NotificationsViewModel viewModel = getIt.get<NotificationsViewModel>();

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    return BlocProvider(
      create: (context) => viewModel,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              locale!.notification,
              style: TextStyles.font14BlackRegular,
            ),
            BlocBuilder(
              bloc: viewModel,
              buildWhen: (previous, current) =>
                  current is NotificationsSwitchState,
              builder: (context, state) {
                bool switcher = false;
                if (state is NotificationsSwitchState) {
                  switcher = state.isNotificationsEnabled;
                }
                return Switch(
                  value: switcher,
                  onChanged: (value) {
                    context.read<NotificationsViewModel>().toggleNotification();
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
      ),
    );
  }
}
