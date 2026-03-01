part of 'chat_message_cubit.dart';

abstract class ChatBotState {}

class ChatBotInitial extends ChatBotState {}

class ChatBotLoading extends ChatBotState {
  final List<ChatMessage> messages;
  ChatBotLoading(this.messages);
}

class ChatBotSuccess extends ChatBotState {
  final List<ChatMessage> messages;
  ChatBotSuccess(this.messages);
}

class ChatBotFailure extends ChatBotState {
  final List<ChatMessage> messages;
  final String error;
  ChatBotFailure(this.messages, this.error);
}
