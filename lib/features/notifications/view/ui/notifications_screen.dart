import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens/config/theme/app_colors.dart';
import 'package:trait_lens/core/di/di.dart';
import 'package:trait_lens/features/notifications/domain/entities/notification_entity.dart';
import 'package:trait_lens/features/notifications/view/view_model/notification_screen_view_model.dart';
import 'package:trait_lens/features/notifications/view/view_model/notifications_screen_states.dart';
import 'package:trait_lens/features/notifications/view/widgets/custom_notification_item.dart';
import 'package:trait_lens/features/notifications/view/widgets/custom_notification_loading_item.dart';
import 'package:trait_lens/features/notifications/view/widgets/notifications_screen_app_bar.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final NotificationScreenViewModel viewModel =
      getIt.get<NotificationScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NotificationsScreenAppBar(),
      body: RefreshIndicator(
        color: ColorsManager.baseBlue,
        backgroundColor: ColorsManager.white,
        onRefresh: () => viewModel.getAllNotifications(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<NotificationScreenViewModel,
              NotificationsScreenStates>(
            bloc: viewModel,
            builder: (context, state) {
              if (state is NotificationsScreenLoadingState) {
                return ListView.separated(
                  itemBuilder: (context, index) =>
                      const CustomNotificationLoadingItem(),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: 8,
                );
              } else if (state is NotificationsScreenErrorState) {
                return Center(child: Text(state.error));
              } else if (state is NotificationsScreenLoadedState) {
                return ListView.separated(
                  itemCount: state.notifications.length,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    NotificationEntity notification =
                        state.notifications[index];
                    return CustomNotificationItem(
                      title: notification.title ?? '',
                      message: notification.message ?? '',
                      notificationId: notification.id ?? '',
                    );
                  },
                );
              } else {
                return ListView(children: const [SizedBox()]);
              }
            },
          ),
        ),
      ),
    );
  }
}
