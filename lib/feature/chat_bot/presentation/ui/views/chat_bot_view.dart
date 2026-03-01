import 'package:auth_api_app/feature/auth/presentation/manger/login_cubit.dart';
import 'package:auth_api_app/feature/chat_bot/data/models/chat_message_model.dart';
import 'package:auth_api_app/feature/chat_bot/data/repos/chat_message_repo_impl.dart';
import 'package:auth_api_app/feature/chat_bot/presentation/manger/chat_message_cubit.dart';
import 'package:auth_api_app/feature/home/presentation/manger/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/theming/app_fonts.dart';
import '../widgets/chat_bot_body.dart';

class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // بنجيب الـ username والـ products من الـ cubits الموجودين
    final loginState = context.read<LoginCubit>().state;
    final productState = context.read<ProductCubit>().state;

    final username = loginState is LoginSuccess
        ? loginState.user.firstName
        : 'User';

    final products = productState is ProductSuccess
        ? productState.productsResponse.products
                  ?.map((p) => p.toJson())
                  .toList() ??
              []
        : <Map<String, dynamic>>[];

    return BlocProvider(
      create: (_) => ChatBotCubit(
        chatBotRepo: ChatBotRepoImpl(),
        username: username,
        products: products,
      ),
      child: const _ChatBotView(),
    );
  }
}

class _ChatBotView extends StatefulWidget {
  const _ChatBotView();

  @override
  State<_ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<_ChatBotView> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _onSend() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    _inputController.clear();
    context.read<ChatBotCubit>().sendMessage(text);
    _scrollToBottom();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text('Smart Assistant', style: AppFonts.font16BlackW500),
            Text(
              'Online',
              style: AppFonts.font14GreyW400.copyWith(
                fontSize: 11,
                color: Colors.green,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined, color: Colors.black87),
            onPressed: () => context.read<ChatBotCubit>().clearChat(),
          ),
        ],
      ),
      body: BlocConsumer<ChatBotCubit, ChatBotState>(
        listener: (context, state) {
          if (state is ChatBotSuccess || state is ChatBotLoading) {
            _scrollToBottom();
          }
        },
        builder: (context, state) {
          final List<ChatMessage> messages = switch (state) {
            ChatBotSuccess s => s.messages,
            ChatBotLoading l => l.messages,
            ChatBotFailure f => f.messages,
            _ => [],
          };

          return ChatBotBody(
            messages: messages,
            scrollController: _scrollController,
            inputController: _inputController,
            onSend: _onSend,
            isLoading: state is ChatBotLoading,
          );
        },
      ),
    );
  }
}
