import 'package:auth_api_app/feature/chat_bot/data/models/chat_message_model.dart';
import 'package:auth_api_app/feature/chat_bot/data/repos/chat_message_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatBotRepoImpl implements ChatBotRepo {
  static const String _baseUrl =
      'https://api.groq.com/openai/v1/chat/completions';
  static const int _maxHistoryMessages = 6;

  final Dio _dio;

  ChatBotRepoImpl() : _dio = Dio();

  @override
  Future<ChatMessage> sendMessage({
    required String userMessage,
    required String username,
    required List<Map<String, dynamic>> products,
    required List<ChatMessage> chatHistory,
  }) async {
    try {
      final messages = _buildMessages(
        systemPrompt: _buildSystemPrompt(username, products),
        chatHistory: chatHistory,
        userMessage: userMessage,
      );

      final response = await _dio.post(
        _baseUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_apiKey',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'model': 'llama-3.1-8b-instant',
          'messages': messages,
          'max_tokens': 512,
          'temperature': 0.7,
        },
      );

      final rawText =
          response.data['choices'][0]['message']['content'] as String;

      final suggestedProduct = _extractSuggestedProduct(rawText, products);
      final cleanText = _cleanText(rawText);

      return ChatMessage(
        text: cleanText,
        type: MessageType.assistant,
        productCard: suggestedProduct,
      );
    } catch (e) {
      print('🔴 ERROR: $e');
      rethrow;
    }
  }

  // ─────────────────────────────────────────────
  //  PRIVATE: BUILD MESSAGES
  // ─────────────────────────────────────────────

  List<Map<String, dynamic>> _buildMessages({
    required String systemPrompt,
    required List<ChatMessage> chatHistory,
    required String userMessage,
  }) {
    final messages = <Map<String, dynamic>>[
      {'role': 'system', 'content': systemPrompt},
    ];

    final recentHistory = chatHistory.length > _maxHistoryMessages
        ? chatHistory.sublist(chatHistory.length - _maxHistoryMessages)
        : chatHistory;

    for (final msg in recentHistory) {
      messages.add({
        'role': msg.type == MessageType.user ? 'user' : 'assistant',
        'content': msg.text,
      });
    }

    messages.add({'role': 'user', 'content': userMessage});

    return messages;
  }

  // ─────────────────────────────────────────────
  //  PRIVATE: BUILD SYSTEM PROMPT
  // ─────────────────────────────────────────────

  String _buildSystemPrompt(
    String username,
    List<Map<String, dynamic>> products,
  ) {
    final productsList = products
        .map((p) => 'ID:${p['id']} | ${p['title']} | \$${p['price']}')
        .join('\n');

    return '''
You are a shopping assistant. User: $username.
Products:
$productsList
- Reply in user's language.
- Max 2 sentences.
- If suggesting a product, end with [PRODUCT_ID:id].
''';
  }

  // ─────────────────────────────────────────────
  //  PRIVATE: HELPERS
  // ─────────────────────────────────────────────

  Map<String, dynamic>? _extractSuggestedProduct(
    String text,
    List<Map<String, dynamic>> products,
  ) {
    final match = RegExp(r'\[PRODUCT_ID:\s*(\d+)\]').firstMatch(text);
    if (match == null) return null;

    final productId = int.tryParse(match.group(1) ?? '');
    if (productId == null) return null;

    try {
      return products.firstWhere((p) => p['id'] == productId);
    } catch (_) {
      return null;
    }
  }

  String _cleanText(String text) {
    return text.replaceAll(RegExp(r'\[PRODUCT_ID:\s*\d+\]'), '').trim();
  }
}
