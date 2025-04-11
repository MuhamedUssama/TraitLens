class NotificationModel {
  static const String collectionName = 'notifications';

  final String? id;
  final String? title;
  final String? message;
  final bool? isRead;

  NotificationModel({
    this.id,
    required this.title,
    required this.message,
    this.isRead = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'message': message, 'isRead': isRead};
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    bool? isRead,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      isRead: isRead ?? this.isRead,
    );
  }
}
