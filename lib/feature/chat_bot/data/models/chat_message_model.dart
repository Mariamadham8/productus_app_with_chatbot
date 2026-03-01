enum MessageType { user, assistant }

class ChatMessage {
  final String text;
  final MessageType type;
  final DateTime time;
  final Map<String, dynamic>? productCard;

  ChatMessage({
    required this.text,
    required this.type,
    DateTime? time,
    this.productCard,
  }) : time = time ?? DateTime.now();
}
