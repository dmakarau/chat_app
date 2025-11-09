import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

class ChatService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Send a message to the chat
  static Future<void> sendMessage({
    required String message,
    required String userId,
  }) async {
    try {
      // Get user profile for message metadata
      final userData = await UserService.getUserProfile(userId: userId);

      if (userData == null) {
        throw Exception('User profile not found');
      }

      // Add message to chat collection
      await _firestore.collection('chat').add({
        'text': message,
        'createdAt': FieldValue.serverTimestamp(),
        'userId': userId,
        'username': userData['username'],
        'userImage': userData['image_url'],
      });
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  /// Get chat messages stream
  static Stream<QuerySnapshot> getChatMessages() {
    return _firestore
        .collection('chat')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Delete a message (if user is the owner)
  static Future<void> deleteMessage({
    required String messageId,
    required String currentUserId,
  }) async {
    try {
      final messageDoc = await _firestore
          .collection('chat')
          .doc(messageId)
          .get();

      if (!messageDoc.exists) {
        throw Exception('Message not found');
      }

      final messageData = messageDoc.data();
      if (messageData?['userId'] != currentUserId) {
        throw Exception('You can only delete your own messages');
      }

      await _firestore.collection('chat').doc(messageId).delete();
    } catch (e) {
      throw Exception('Failed to delete message: $e');
    }
  }
}
