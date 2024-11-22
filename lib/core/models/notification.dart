class Notification {
  final String receiverId;
  final String senderName;
  final String title;
  final String content;
  final DateTime createdAt;
  final bool isRead;
  final String notificationType;

  Notification({
    required this.receiverId,
    required this.senderName,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.isRead,
    required this.notificationType,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      receiverId: json['receiverId'],
      senderName: json['senderName'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      isRead: json['isRead'],
      notificationType: json['notificationType'],
    );
  }
}
