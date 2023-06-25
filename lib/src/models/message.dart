class Message {
  final String content;
  final String nonce;
  final String mac;
  final String createdAt;

  const Message({
    required this.content,
    required this.nonce,
    required this.mac,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['message'],
      nonce: json['nonce'],
      mac: json['mac'],
      createdAt: json['createdAt'],
    );
  }
}
