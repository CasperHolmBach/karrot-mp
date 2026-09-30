class Message {
  final String text;
  final bool isMine;
  final DateTime sentAt;

  Message({required this.text, required this.isMine, required this.sentAt});

  // TODO: factory Message.fromJson(Map<String, dynamic> j)
  // TODO: Map<String, dynamic> toJson()
}
