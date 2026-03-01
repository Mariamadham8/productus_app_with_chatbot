import 'package:auth_api_app/feature/chat_bot/data/models/chat_message_model.dart';
import 'package:auth_api_app/feature/chat_bot/presentation/ui/widgets/chat_input.dart';
import 'package:auth_api_app/feature/chat_bot/presentation/ui/widgets/message_list_view.dart';
import 'package:flutter/material.dart';

class ChatBotBody extends StatelessWidget {
  final List<ChatMessage> messages;
  final ScrollController scrollController;
  final TextEditingController inputController;
  final VoidCallback onSend;
  final bool isLoading;

  const ChatBotBody({
    super.key,
    required this.messages,
    required this.scrollController,
    required this.inputController,
    required this.onSend,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Messages list
        Expanded(
          child: ChatMessagesListView(
            messages: messages,
            scrollController: scrollController,
          ),
        ),

        // Input bar
        ChatInputBar(
          controller: inputController,
          onSend: onSend,
          isLoading: isLoading,
        ),
      ],
    );
  }
}
