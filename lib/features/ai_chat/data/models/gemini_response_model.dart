class MessageModel {
  final String text;
  final bool isUser;

  MessageModel({
    required this.text,
    required this.isUser,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json['text'] as String,
      isUser: json['isUser'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isUser': isUser,
    };
  }
}
