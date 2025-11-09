import 'package:flutter/material.dart';
import '../widgets/chat/chat_app_bar.dart';
import '../widgets/composer.dart';
import '../widgets/messages_list.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: const ChatAppBar(),
      body: Column(
        children: [
          Divider(
            height: 1,
            thickness: 0.5,
            color: theme.colorScheme.outlineVariant,
          ),
          const Expanded(child: ChatMessagesList()),
          const ChatComposer(),
        ],
      ),
    );
  }
}
