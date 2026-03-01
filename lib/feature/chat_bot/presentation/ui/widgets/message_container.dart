import 'package:auth_api_app/feature/chat_bot/data/models/chat_message_model.dart';
import 'package:auth_api_app/feature/chat_bot/presentation/ui/widgets/product_sugession.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/theming/app_color.dart';
import '../../../../../../../core/theming/app_fonts.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  bool get isUser => message.type == MessageType.user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Column(
        crossAxisAlignment: isUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          // Label
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              isUser ? 'Me' : 'Assistant',
              style: AppFonts.font14GreyW400.copyWith(fontSize: 11),
            ),
          ),

          Row(
            mainAxisAlignment: isUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Avatar للـ assistant
              if (!isUser) ...[
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.primaryColor.withOpacity(0.15),
                  child: const Icon(
                    Icons.auto_awesome,
                    size: 16,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(width: 8),
              ],

              // Bubble
              Flexible(
                child: Column(
                  crossAxisAlignment: isUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    // Text bubble
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isUser ? AppColors.primaryColor : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: Radius.circular(isUser ? 16 : 4),
                          bottomRight: Radius.circular(isUser ? 4 : 16),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        message.text,
                        style: AppFonts.font14BlackW500.copyWith(
                          color: isUser ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    // Product card لو موجودة
                    if (message.productCard != null) ...[
                      const SizedBox(height: 8),
                      ProductSuggestionCard(product: message.productCard!),
                    ],
                  ],
                ),
              ),

              // Avatar للـ user
              if (isUser) ...[
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.primaryColor.withOpacity(0.15),
                  child: const Icon(
                    Icons.person_outline,
                    size: 16,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
