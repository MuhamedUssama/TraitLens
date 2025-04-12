import 'package:trait_lens/features/notifications/domain/entities/notification_entity.dart';

abstract class NotificationsTabStates {}

class NotificationsTabInitialState extends NotificationsTabStates {}

class NotificationsTabLoadingState extends NotificationsTabStates {}

class NotificationsTabLoadedState extends NotificationsTabStates {
  final List<NotificationEntity> notifications;

  NotificationsTabLoadedState(this.notifications);
}

class NotificationsTabErrorState extends NotificationsTabStates {
  final String error;

  NotificationsTabErrorState(this.error);
}
