import 'package:trait_lens/features/notifications/domain/entities/notification_entity.dart';

abstract class NotificationsScreenStates {}

class NotificationsScreenInitialState extends NotificationsScreenStates {}

class NotificationsScreenLoadingState extends NotificationsScreenStates {}

class NotificationsScreenLoadedState extends NotificationsScreenStates {
  final List<NotificationEntity> notifications;

  NotificationsScreenLoadedState(this.notifications);
}

class NotificationsScreenErrorState extends NotificationsScreenStates {
  final String error;

  NotificationsScreenErrorState(this.error);
}
