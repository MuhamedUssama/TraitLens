abstract class NotificationsStates {}

class NotificationsInitialState extends NotificationsStates {}

class NotificationsSwitchState extends NotificationsStates {
  final bool isNotificationsEnabled;

  NotificationsSwitchState(this.isNotificationsEnabled);
}
