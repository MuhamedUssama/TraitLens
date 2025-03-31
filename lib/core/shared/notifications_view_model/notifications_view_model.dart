import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/cache/shared_preferences.dart';

import 'notifications_states.dart';

@injectable
class NotificationsViewModel extends Cubit<NotificationsStates> {
  NotificationsViewModel() : super(NotificationsInitialState()) {
    _loadNotificationState();
  }

  static const String _notificationsKey = "isNotificationsEnabled";

  void _loadNotificationState() {
    bool isEnabled = SharedPreferencesHelper.getBool(key: _notificationsKey);
    emit(NotificationsSwitchState(isEnabled));
  }

  void toggleNotification() {
    if (state is NotificationsSwitchState) {
      NotificationsSwitchState currentState = state as NotificationsSwitchState;
      bool newState = !currentState.isNotificationsEnabled;

      SharedPreferencesHelper.saveData(key: _notificationsKey, value: newState);
      emit(NotificationsSwitchState(newState));
    }
  }
}
