class Message {
  final String content;
  final String createdAt;

  const Message({
    required this.content,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['message'],
      createdAt: json['createdAt'],
    );
  }
}
