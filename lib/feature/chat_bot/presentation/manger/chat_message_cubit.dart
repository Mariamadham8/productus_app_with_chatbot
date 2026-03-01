import 'package:auth_api_app/feature/chat_bot/data/models/chat_message_model.dart';
import 'package:auth_api_app/feature/chat_bot/data/repos/chat_message_repo.dart';
import 'package:bloc/bloc.dart';

part 'chat_message_state.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  final ChatBotRepo chatBotRepo;
  final String username;
  final List<Map<String, dynamic>> products;

  final List<ChatMessage> _messages = [];

  ChatBotCubit({
    required this.chatBotRepo,
    required this.username,
    required this.products,
  }) : super(ChatBotInitial()) {
    _messages.add(
      ChatMessage(
        text: 'Hello $username! 👋 What are you looking for today?',
        type: MessageType.assistant,
      ),
    );
    emit(ChatBotSuccess(List.from(_messages)));
  }

  Future<void> sendMessage(String userMessage) async {
    if (userMessage.trim().isEmpty) return;

    _messages.add(ChatMessage(text: userMessage, type: MessageType.user));
    emit(ChatBotLoading(List.from(_messages)));

    try {
      final response = await chatBotRepo.sendMessage(
        userMessage: userMessage,
        username: username,
        products: products,
        chatHistory: List.from(_messages)..removeLast(),
      );
      _messages.add(response);
      emit(ChatBotSuccess(List.from(_messages)));
    } catch (e) {
      final error = e.toString();
      final message = error.contains('429') || error.contains('rate')
          ? '⏳ Too many requests. Please wait and try again.'
          : '❌ Something went wrong. Please try again.';

      _messages.add(ChatMessage(text: message, type: MessageType.assistant));
      emit(ChatBotFailure(List.from(_messages), error));
    }
  }

  void clearChat() {
    _messages.clear();
    _messages.add(
      ChatMessage(
        text: 'Hello $username! 👋 How can I help you today?',
        type: MessageType.assistant,
      ),
    );
    emit(ChatBotSuccess(List.from(_messages)));
  }
}
