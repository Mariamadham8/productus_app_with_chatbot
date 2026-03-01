import 'package:auth_api_app/feature/chat_bot/data/models/chat_message_model.dart';

abstract class ChatBotRepo {
  Future<ChatMessage> sendMessage({
    required String userMessage,
    required String username,
    required List<Map<String, dynamic>> products,
    required List<ChatMessage> chatHistory,
  });
}
