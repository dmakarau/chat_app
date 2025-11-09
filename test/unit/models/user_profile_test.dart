import 'package:flutter_test/flutter_test.dart';
import 'package:chat_app/models/user_profile.dart';

void main() {
  group('UserProfile Tests', () {
    group('Constructor Tests', () {
      test('should create UserProfile with required fields', () {
        // Arrange
        const id = 'user123';
        const username = 'testuser';
        const email = 'test@example.com';

        // Act
        const userProfile = UserProfile(
          id: id,
          username: username,
          email: email,
        );

        // Assert
        expect(userProfile.id, equals(id));
        expect(userProfile.username, equals(username));
        expect(userProfile.email, equals(email));
        expect(userProfile.imageUrl, isNull);
        expect(userProfile.createdAt, isNull);
        expect(userProfile.updatedAt, isNull);
      });

      test('should create UserProfile with all fields', () {
        // Arrange
        const id = 'user123';
        const username = 'testuser';
        const email = 'test@example.com';
        const imageUrl = 'https://example.com/image.jpg';
        final createdAt = DateTime(2024, 1, 1);
        final updatedAt = DateTime(2024, 1, 2);

        // Act
        final userProfile = UserProfile(
          id: id,
          username: username,
          email: email,
          imageUrl: imageUrl,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

        // Assert
        expect(userProfile.id, equals(id));
        expect(userProfile.username, equals(username));
        expect(userProfile.email, equals(email));
        expect(userProfile.imageUrl, equals(imageUrl));
        expect(userProfile.createdAt, equals(createdAt));
        expect(userProfile.updatedAt, equals(updatedAt));
      });
    });

    group('fromFirestore Tests', () {
      test('should create UserProfile from Firestore data with all fields', () {
        // Arrange
        const id = 'user123';
        const username = 'testuser';
        const email = 'test@example.com';
        const imageUrl = 'https://example.com/image.jpg';
        final createdAt = DateTime(2024, 1, 1);
        final updatedAt = DateTime(2024, 1, 2);

        final data = {
          'username': username,
          'email': email,
          'image_url': imageUrl,
          'created_at': MockTimestamp(createdAt),
          'updated_at': MockTimestamp(updatedAt),
        };

        // Act
        final userProfile = UserProfile.fromFirestore(data, id);

        // Assert
        expect(userProfile.id, equals(id));
        expect(userProfile.username, equals(username));
        expect(userProfile.email, equals(email));
        expect(userProfile.imageUrl, equals(imageUrl));
        expect(userProfile.createdAt, equals(createdAt));
        expect(userProfile.updatedAt, equals(updatedAt));
      });

      test('should create UserProfile from Firestore data with missing optional fields', () {
        // Arrange
        const id = 'user123';
        const username = 'testuser';
        const email = 'test@example.com';

        final data = {
          'username': username,
          'email': email,
        };

        // Act
        final userProfile = UserProfile.fromFirestore(data, id);

        // Assert
        expect(userProfile.id, equals(id));
        expect(userProfile.username, equals(username));
        expect(userProfile.email, equals(email));
        expect(userProfile.imageUrl, isNull);
        expect(userProfile.createdAt, isNull);
        expect(userProfile.updatedAt, isNull);
      });

      test('should create UserProfile with default values for missing required fields', () {
        // Arrange
        const id = 'user123';
        final data = <String, dynamic>{};

        // Act
        final userProfile = UserProfile.fromFirestore(data, id);

        // Assert
        expect(userProfile.id, equals(id));
        expect(userProfile.username, equals(''));
        expect(userProfile.email, equals(''));
        expect(userProfile.imageUrl, isNull);
        expect(userProfile.createdAt, isNull);
        expect(userProfile.updatedAt, isNull);
      });
    });

    group('toFirestore Tests', () {
      test('should convert UserProfile to Firestore data with all fields', () {
        // Arrange
        const id = 'user123';
        const username = 'testuser';
        const email = 'test@example.com';
        const imageUrl = 'https://example.com/image.jpg';
        final createdAt = DateTime(2024, 1, 1);
        final updatedAt = DateTime(2024, 1, 2);

        final userProfile = UserProfile(
          id: id,
          username: username,
          email: email,
          imageUrl: imageUrl,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

        // Act
        final firestoreData = userProfile.toFirestore();

        // Assert
        expect(firestoreData['username'], equals(username));
        expect(firestoreData['email'], equals(email));
        expect(firestoreData['image_url'], equals(imageUrl));
        expect(firestoreData['created_at'], equals(createdAt));
        expect(firestoreData['updated_at'], equals(updatedAt));
      });

      test('should convert UserProfile to Firestore data with null optional fields', () {
        // Arrange
        const userProfile = UserProfile(
          id: 'user123',
          username: 'testuser',
          email: 'test@example.com',
        );

        // Act
        final firestoreData = userProfile.toFirestore();

        // Assert
        expect(firestoreData['username'], equals('testuser'));
        expect(firestoreData['email'], equals('test@example.com'));
        expect(firestoreData['image_url'], isNull);
        expect(firestoreData['created_at'], isNull);
        expect(firestoreData['updated_at'], isNull);
      });

      test('should not include id in Firestore data', () {
        // Arrange
        const userProfile = UserProfile(
          id: 'user123',
          username: 'testuser',
          email: 'test@example.com',
        );

        // Act
        final firestoreData = userProfile.toFirestore();

        // Assert
        expect(firestoreData.containsKey('id'), isFalse);
      });
    });

    group('copyWith Tests', () {
      test('should create copy with updated username', () {
        // Arrange
        const originalProfile = UserProfile(
          id: 'user123',
          username: 'oldusername',
          email: 'test@example.com',
        );

        // Act
        final updatedProfile = originalProfile.copyWith(username: 'newusername');

        // Assert
        expect(updatedProfile.id, equals(originalProfile.id));
        expect(updatedProfile.username, equals('newusername'));
        expect(updatedProfile.email, equals(originalProfile.email));
        expect(updatedProfile.imageUrl, equals(originalProfile.imageUrl));
        expect(updatedProfile.createdAt, equals(originalProfile.createdAt));
        expect(updatedProfile.updatedAt, equals(originalProfile.updatedAt));
      });

      test('should create copy with updated email', () {
        // Arrange
        const originalProfile = UserProfile(
          id: 'user123',
          username: 'testuser',
          email: 'old@example.com',
        );

        // Act
        final updatedProfile = originalProfile.copyWith(email: 'new@example.com');

        // Assert
        expect(updatedProfile.id, equals(originalProfile.id));
        expect(updatedProfile.username, equals(originalProfile.username));
        expect(updatedProfile.email, equals('new@example.com'));
      });

      test('should create copy with updated imageUrl', () {
        // Arrange
        const originalProfile = UserProfile(
          id: 'user123',
          username: 'testuser',
          email: 'test@example.com',
        );

        // Act
        final updatedProfile = originalProfile.copyWith(
          imageUrl: 'https://example.com/new-image.jpg',
        );

        // Assert
        expect(updatedProfile.imageUrl, equals('https://example.com/new-image.jpg'));
        expect(updatedProfile.id, equals(originalProfile.id));
        expect(updatedProfile.username, equals(originalProfile.username));
        expect(updatedProfile.email, equals(originalProfile.email));
      });

      test('should create copy with updated dates', () {
        // Arrange
        final originalProfile = UserProfile(
          id: 'user123',
          username: 'testuser',
          email: 'test@example.com',
          createdAt: DateTime(2024, 1, 1),
          updatedAt: DateTime(2024, 1, 2),
        );

        final newUpdatedAt = DateTime(2024, 1, 3);

        // Act
        final updatedProfile = originalProfile.copyWith(updatedAt: newUpdatedAt);

        // Assert
        expect(updatedProfile.updatedAt, equals(newUpdatedAt));
        expect(updatedProfile.createdAt, equals(originalProfile.createdAt));
      });

      test('should create identical copy when no parameters provided', () {
        // Arrange
        final originalProfile = UserProfile(
          id: 'user123',
          username: 'testuser',
          email: 'test@example.com',
          imageUrl: 'https://example.com/image.jpg',
          createdAt: DateTime(2024, 1, 1),
          updatedAt: DateTime(2024, 1, 2),
        );

        // Act
        final copiedProfile = originalProfile.copyWith();

        // Assert
        expect(copiedProfile.id, equals(originalProfile.id));
        expect(copiedProfile.username, equals(originalProfile.username));
        expect(copiedProfile.email, equals(originalProfile.email));
        expect(copiedProfile.imageUrl, equals(originalProfile.imageUrl));
        expect(copiedProfile.createdAt, equals(originalProfile.createdAt));
        expect(copiedProfile.updatedAt, equals(originalProfile.updatedAt));
      });

      test('should not modify original profile when copying', () {
        // Arrange
        const originalProfile = UserProfile(
          id: 'user123',
          username: 'testuser',
          email: 'test@example.com',
        );

        // Act
        originalProfile.copyWith(username: 'newusername');

        // Assert - original should remain unchanged
        expect(originalProfile.username, equals('testuser'));
      });
    });

    group('Edge Cases', () {
      test('should handle empty strings', () {
        // Arrange & Act
        const userProfile = UserProfile(
          id: '',
          username: '',
          email: '',
        );

        // Assert
        expect(userProfile.id, equals(''));
        expect(userProfile.username, equals(''));
        expect(userProfile.email, equals(''));
      });

      test('should handle very long strings', () {
        // Arrange
        final longString = 'a' * 1000;

        // Act
        final userProfile = UserProfile(
          id: longString,
          username: longString,
          email: '$longString@example.com',
        );

        // Assert
        expect(userProfile.id, equals(longString));
        expect(userProfile.username, equals(longString));
        expect(userProfile.email, equals('$longString@example.com'));
      });
    });
  });
}

// Mock class for Firestore Timestamp
class MockTimestamp {
  final DateTime _dateTime;

  MockTimestamp(this._dateTime);

  DateTime toDate() => _dateTime;
}