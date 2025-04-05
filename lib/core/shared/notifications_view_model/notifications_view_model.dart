import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/cache/shared_preferences.dart';
import 'package:trait_lens/core/constants/app_constants.dart';

import 'notifications_states.dart';

@injectable
class NotificationsViewModel extends Cubit<NotificationsStates> {
  NotificationsViewModel() : super(NotificationsInitialState()) {
    _loadNotificationState();
  }

  void _loadNotificationState() {
    bool isEnabled =
        SharedPreferencesHelper.getBool(key: AppConstants.notificationsKey);

    if (isEnabled) {
      _subscribeToNotifications();
    } else {
      _unsubscribeFromNotifications();
    }

    emit(NotificationsSwitchState(isEnabled));
  }

  void toggleNotification() {
    if (state is NotificationsSwitchState) {
      NotificationsSwitchState currentState = state as NotificationsSwitchState;
      bool newState = !currentState.isNotificationsEnabled;

      SharedPreferencesHelper.saveData(
        key: AppConstants.notificationsKey,
        value: newState,
      );

      if (newState) {
        _subscribeToNotifications();
      } else {
        _unsubscribeFromNotifications();
      }

      emit(NotificationsSwitchState(newState));
    }
  }

  void _subscribeToNotifications() async {
    await FirebaseMessaging.instance.subscribeToTopic('general');
    log('User subscribed to notifications.');
  }

  void _unsubscribeFromNotifications() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic('general');
    log('User unsubscribed from notifications.');
  }
}
