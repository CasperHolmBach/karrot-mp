class Message {
  final String text;
  final bool isMine;
  final DateTime sentAt;

  Message({required this.text, required this.isMine, required this.sentAt});

  // sentAt is stored as ISO-8601.
  factory Message.fromJson(Map<String, dynamic> j) {
    return Message(
      text: j['text'] as String,
      isMine: j['isMine'] as bool,
      sentAt: DateTime.parse(j['sentAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'isMine': isMine, 'sentAt': sentAt.toIso8601String()};
  }
}
