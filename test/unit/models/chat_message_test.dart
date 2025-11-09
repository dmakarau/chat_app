import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:chat_app/models/chat_message.dart';

// Generate mocks
@GenerateMocks([DocumentSnapshot, Timestamp])
import 'chat_message_test.mocks.dart';

void main() {
  group('ChatMessage Tests', () {
    group('Constructor Tests', () {
      test('should create ChatMessage with required fields', () {
        // Arrange
        const id = 'msg123';
        const text = 'Hello world';
        const userId = 'user123';
        const username = 'testuser';

        // Act
        const chatMessage = ChatMessage(
          id: id,
          text: text,
          userId: userId,
          username: username,
        );

        // Assert
        expect(chatMessage.id, equals(id));
        expect(chatMessage.text, equals(text));
        expect(chatMessage.userId, equals(userId));
        expect(chatMessage.username, equals(username));
        expect(chatMessage.userImage, isNull);
        expect(chatMessage.createdAt, isNull);
      });

      test('should create ChatMessage with all fields', () {
        // Arrange
        const id = 'msg123';
        const text = 'Hello world';
        const userId = 'user123';
        const username = 'testuser';
        const userImage = 'https://example.com/avatar.jpg';
        final createdAt = DateTime(2024, 1, 1);

        // Act
        final chatMessage = ChatMessage(
          id: id,
          text: text,
          userId: userId,
          username: username,
          userImage: userImage,
          createdAt: createdAt,
        );

        // Assert
        expect(chatMessage.id, equals(id));
        expect(chatMessage.text, equals(text));
        expect(chatMessage.userId, equals(userId));
        expect(chatMessage.username, equals(username));
        expect(chatMessage.userImage, equals(userImage));
        expect(chatMessage.createdAt, equals(createdAt));
      });
    });

    group('fromFirestore Tests', () {
      late MockDocumentSnapshot mockDocumentSnapshot;
      late MockTimestamp mockTimestamp;

      setUp(() {
        mockDocumentSnapshot = MockDocumentSnapshot();
        mockTimestamp = MockTimestamp();
      });

      test('should create ChatMessage from Firestore document with all fields', () {
        // Arrange
        const id = 'msg123';
        const text = 'Hello world';
        const userId = 'user123';
        const username = 'testuser';
        const userImage = 'https://example.com/avatar.jpg';
        final createdAt = DateTime(2024, 1, 1);

        final data = {
          'text': text,
          'userId': userId,
          'username': username,
          'userImage': userImage,
          'createdAt': mockTimestamp,
        };

        when(mockDocumentSnapshot.id).thenReturn(id);
        when(mockDocumentSnapshot.data()).thenReturn(data);
        when(mockTimestamp.toDate()).thenReturn(createdAt);

        // Act
        final chatMessage = ChatMessage.fromFirestore(mockDocumentSnapshot);

        // Assert
        expect(chatMessage.id, equals(id));
        expect(chatMessage.text, equals(text));
        expect(chatMessage.userId, equals(userId));
        expect(chatMessage.username, equals(username));
        expect(chatMessage.userImage, equals(userImage));
        expect(chatMessage.createdAt, equals(createdAt));
      });

      test('should create ChatMessage from Firestore document with missing optional fields', () {
        // Arrange
        const id = 'msg123';
        const text = 'Hello world';
        const userId = 'user123';
        const username = 'testuser';

        final data = {
          'text': text,
          'userId': userId,
          'username': username,
        };

        when(mockDocumentSnapshot.id).thenReturn(id);
        when(mockDocumentSnapshot.data()).thenReturn(data);

        // Act
        final chatMessage = ChatMessage.fromFirestore(mockDocumentSnapshot);

        // Assert
        expect(chatMessage.id, equals(id));
        expect(chatMessage.text, equals(text));
        expect(chatMessage.userId, equals(userId));
        expect(chatMessage.username, equals(username));
        expect(chatMessage.userImage, isNull);
        expect(chatMessage.createdAt, isNull);
      });

      test('should create ChatMessage with default values for missing required fields', () {
        // Arrange
        const id = 'msg123';
        final data = <String, dynamic>{};

        when(mockDocumentSnapshot.id).thenReturn(id);
        when(mockDocumentSnapshot.data()).thenReturn(data);

        // Act
        final chatMessage = ChatMessage.fromFirestore(mockDocumentSnapshot);

        // Assert
        expect(chatMessage.id, equals(id));
        expect(chatMessage.text, equals(''));
        expect(chatMessage.userId, equals(''));
        expect(chatMessage.username, equals(''));
        expect(chatMessage.userImage, isNull);
        expect(chatMessage.createdAt, isNull);
      });

      test('should handle null timestamp properly', () {
        // Arrange
        const id = 'msg123';
        final data = {
          'text': 'Hello world',
          'userId': 'user123',
          'username': 'testuser',
          'createdAt': null,
        };

        when(mockDocumentSnapshot.id).thenReturn(id);
        when(mockDocumentSnapshot.data()).thenReturn(data);

        // Act
        final chatMessage = ChatMessage.fromFirestore(mockDocumentSnapshot);

        // Assert
        expect(chatMessage.createdAt, isNull);
      });
    });

    group('toFirestore Tests', () {
      test('should convert ChatMessage to Firestore data with all fields', () {
        // Arrange
        const id = 'msg123';
        const text = 'Hello world';
        const userId = 'user123';
        const username = 'testuser';
        const userImage = 'https://example.com/avatar.jpg';
        final createdAt = DateTime(2024, 1, 1);

        final chatMessage = ChatMessage(
          id: id,
          text: text,
          userId: userId,
          username: username,
          userImage: userImage,
          createdAt: createdAt,
        );

        // Act
        final firestoreData = chatMessage.toFirestore();

        // Assert
        expect(firestoreData['text'], equals(text));
        expect(firestoreData['userId'], equals(userId));
        expect(firestoreData['username'], equals(username));
        expect(firestoreData['userImage'], equals(userImage));
        expect(firestoreData['createdAt'], isA<Timestamp>());
      });

      test('should convert ChatMessage to Firestore data with null optional fields', () {
        // Arrange
        const chatMessage = ChatMessage(
          id: 'msg123',
          text: 'Hello world',
          userId: 'user123',
          username: 'testuser',
        );

        // Act
        final firestoreData = chatMessage.toFirestore();

        // Assert
        expect(firestoreData['text'], equals('Hello world'));
        expect(firestoreData['userId'], equals('user123'));
        expect(firestoreData['username'], equals('testuser'));
        expect(firestoreData['userImage'], isNull);
        expect(firestoreData['createdAt'], equals(FieldValue.serverTimestamp()));
      });

      test('should not include id in Firestore data', () {
        // Arrange
        const chatMessage = ChatMessage(
          id: 'msg123',
          text: 'Hello world',
          userId: 'user123',
          username: 'testuser',
        );

        // Act
        final firestoreData = chatMessage.toFirestore();

        // Assert
        expect(firestoreData.containsKey('id'), isFalse);
      });

      test('should use server timestamp when createdAt is null', () {
        // Arrange
        const chatMessage = ChatMessage(
          id: 'msg123',
          text: 'Hello world',
          userId: 'user123',
          username: 'testuser',
        );

        // Act
        final firestoreData = chatMessage.toFirestore();

        // Assert
        expect(firestoreData['createdAt'], equals(FieldValue.serverTimestamp()));
      });

      test('should convert createdAt to Timestamp when present', () {
        // Arrange
        final createdAt = DateTime(2024, 1, 1);
        final chatMessage = ChatMessage(
          id: 'msg123',
          text: 'Hello world',
          userId: 'user123',
          username: 'testuser',
          createdAt: createdAt,
        );

        // Act
        final firestoreData = chatMessage.toFirestore();

        // Assert
        expect(firestoreData['createdAt'], isA<Timestamp>());
        final timestamp = firestoreData['createdAt'] as Timestamp;
        expect(timestamp.toDate(), equals(createdAt));
      });
    });

    group('Edge Cases', () {
      test('should handle empty strings', () {
        // Arrange & Act
        const chatMessage = ChatMessage(
          id: '',
          text: '',
          userId: '',
          username: '',
        );

        // Assert
        expect(chatMessage.id, equals(''));
        expect(chatMessage.text, equals(''));
        expect(chatMessage.userId, equals(''));
        expect(chatMessage.username, equals(''));
      });

      test('should handle very long text messages', () {
        // Arrange
        final longText = 'a' * 10000;

        // Act
        final chatMessage = ChatMessage(
          id: 'msg123',
          text: longText,
          userId: 'user123',
          username: 'testuser',
        );

        // Assert
        expect(chatMessage.text, equals(longText));
        expect(chatMessage.text.length, equals(10000));
      });

      test('should handle special characters in text', () {
        // Arrange
        const specialText = '🚀 Hello! @user #hashtag \$special chars & symbols';

        // Act
        const chatMessage = ChatMessage(
          id: 'msg123',
          text: specialText,
          userId: 'user123',
          username: 'testuser',
        );

        // Assert
        expect(chatMessage.text, equals(specialText));
      });

      test('should handle URLs in userImage field', () {
        // Arrange
        const imageUrls = [
          'https://example.com/image.jpg',
          'http://localhost:3000/avatar.png',
          'https://subdomain.domain.co.uk/path/to/image.gif',
        ];

        for (final url in imageUrls) {
          // Act
          final chatMessage = ChatMessage(
            id: 'msg123',
            text: 'Hello',
            userId: 'user123',
            username: 'testuser',
            userImage: url,
          );

          // Assert
          expect(chatMessage.userImage, equals(url));
        }
      });

      test('should handle future and past dates', () {
        // Arrange
        final pastDate = DateTime(2000, 1, 1);
        final futureDate = DateTime(2030, 12, 31);

        // Act
        final pastMessage = ChatMessage(
          id: 'msg1',
          text: 'Past message',
          userId: 'user123',
          username: 'testuser',
          createdAt: pastDate,
        );

        final futureMessage = ChatMessage(
          id: 'msg2',
          text: 'Future message',
          userId: 'user123',
          username: 'testuser',
          createdAt: futureDate,
        );

        // Assert
        expect(pastMessage.createdAt, equals(pastDate));
        expect(futureMessage.createdAt, equals(futureDate));
      });
    });
  });
}