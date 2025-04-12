class NotificationEntity {
  final String? id;
  final String? title;
  final String? message;
  final bool? isRead;

  NotificationEntity({
    this.id,
    required this.title,
    required this.message,
    this.isRead = false,
  });
}
