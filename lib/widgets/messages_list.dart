import 'package:chat_app/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/chat_service.dart';

class ChatMessagesList extends StatelessWidget {
  const ChatMessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = AuthService.currentUser;

    if (authenticatedUser == null) {
      return const Center(child: Text('User not authenticated'));
    }

    return StreamBuilder(
      stream: ChatService.getChatMessages(),
      builder: (ct, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No messages found.'));
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('An error occurred while fetching messages.'),
          );
        }

        final loadedMessages = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 16, top: 16),
          reverse: true,
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) {
            final chatMessage =
                loadedMessages[index].data() as Map<String, dynamic>;
            final nextChatMessage = index + 1 < loadedMessages.length
                ? loadedMessages[index + 1].data() as Map<String, dynamic>
                : null;

            final currenMessageUserId = chatMessage['userId'];
            final nextMessageUserId = nextChatMessage != null
                ? nextChatMessage['userId']
                : null;
            final isSameUser = currenMessageUserId == nextMessageUserId;

            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: isSameUser
                  ? MessageBubble.next(
                      message: chatMessage['text'],
                      isMe: authenticatedUser.uid == currenMessageUserId,
                    )
                  : MessageBubble.first(
                      message: chatMessage['text'],
                      username: chatMessage['username'],
                      userImage: chatMessage['userImage'],
                      isMe: authenticatedUser.uid == currenMessageUserId,
                    ),
            );
          },
        );
      },
    );
  }
}
