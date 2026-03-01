import 'package:auth_api_app/feature/chat_bot/data/models/chat_message_model.dart';
import 'package:auth_api_app/feature/chat_bot/presentation/ui/widgets/message_container.dart';
import 'package:flutter/material.dart';

class ChatMessagesListView extends StatelessWidget {
  final List<ChatMessage> messages;
  final ScrollController scrollController;

  const ChatMessagesListView({
    super.key,
    required this.messages,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return MessageBubble(message: messages[index]);
      },
    );
  }
}
