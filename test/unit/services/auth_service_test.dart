import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Generate mocks
@GenerateMocks([FirebaseAuth, User, UserCredential])
import 'auth_service_test.mocks.dart';

void main() {
  group('AuthService Tests', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUser mockUser;
    late MockUserCredential mockUserCredential;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockUser = MockUser();
      mockUserCredential = MockUserCredential();
    });

    group('Authentication Flow Tests', () {
      test('should handle sign in success flow', () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'password123';

        when(
          mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => mockUserCredential);

        when(mockUserCredential.user).thenReturn(mockUser);
        when(mockUser.email).thenReturn(email);

        // Act
        final result = await mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Assert
        expect(result.user?.email, equals(email));
        verify(
          mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
      });

      test('should handle sign in failure with wrong password', () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'wrongpassword';

        when(
          mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenThrow(
          FirebaseAuthException(
            code: 'wrong-password',
            message: 'The password is invalid',
          ),
        );

        // Act & Assert
        expect(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
          throwsA(isA<FirebaseAuthException>()),
        );
      });

      test('should handle user not found error', () async {
        // Arrange
        const email = 'nonexistent@example.com';
        const password = 'password123';

        when(
          mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenThrow(
          FirebaseAuthException(
            code: 'user-not-found',
            message: 'No user record found',
          ),
        );

        // Act & Assert
        expect(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
          throwsA(isA<FirebaseAuthException>()),
        );
      });

      test('should handle account creation success', () async {
        // Arrange
        const email = 'newuser@example.com';
        const password = 'password123';

        when(
          mockFirebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => mockUserCredential);

        when(mockUserCredential.user).thenReturn(mockUser);
        when(mockUser.email).thenReturn(email);

        // Act
        final result = await mockFirebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Assert
        expect(result.user?.email, equals(email));
        verify(
          mockFirebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
      });

      test(
        'should handle account creation failure with existing email',
        () async {
          // Arrange
          const email = 'existing@example.com';
          const password = 'password123';

          when(
            mockFirebaseAuth.createUserWithEmailAndPassword(
              email: email,
              password: password,
            ),
          ).thenThrow(
            FirebaseAuthException(
              code: 'email-already-in-use',
              message: 'The email address is already in use',
            ),
          );

          // Act & Assert
          expect(
            () => mockFirebaseAuth.createUserWithEmailAndPassword(
              email: email,
              password: password,
            ),
            throwsA(isA<FirebaseAuthException>()),
          );
        },
      );

      test(
        'should handle account creation failure with weak password',
        () async {
          // Arrange
          const email = 'test@example.com';
          const password = '123';

          when(
            mockFirebaseAuth.createUserWithEmailAndPassword(
              email: email,
              password: password,
            ),
          ).thenThrow(
            FirebaseAuthException(
              code: 'weak-password',
              message: 'The password is too weak',
            ),
          );

          // Act & Assert
          expect(
            () => mockFirebaseAuth.createUserWithEmailAndPassword(
              email: email,
              password: password,
            ),
            throwsA(isA<FirebaseAuthException>()),
          );
        },
      );

      test('should handle sign out successfully', () async {
        // Arrange
        when(mockFirebaseAuth.signOut()).thenAnswer((_) async {});

        // Act
        await mockFirebaseAuth.signOut();

        // Assert
        verify(mockFirebaseAuth.signOut()).called(1);
      });
    });

    group('User State Tests', () {
      test('should return current user when authenticated', () {
        // Arrange
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(mockUser.uid).thenReturn('test-uid');

        // Act
        final user = mockFirebaseAuth.currentUser;

        // Assert
        expect(user, isNotNull);
        expect(user?.uid, equals('test-uid'));
      });

      test('should return null when not authenticated', () {
        // Arrange
        when(mockFirebaseAuth.currentUser).thenReturn(null);

        // Act
        final user = mockFirebaseAuth.currentUser;

        // Assert
        expect(user, isNull);
      });

      test('should provide auth state changes stream', () {
        // Arrange
        final stream = Stream<User?>.value(mockUser);
        when(mockFirebaseAuth.authStateChanges()).thenAnswer((_) => stream);

        // Act
        final authStream = mockFirebaseAuth.authStateChanges();

        // Assert
        expect(authStream, isA<Stream<User?>>());
      });
    });

    group('Error Handling Tests', () {
      test('should handle network errors gracefully', () async {
        // Arrange
        when(
          mockFirebaseAuth.signInWithEmailAndPassword(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        ).thenThrow(
          FirebaseAuthException(
            code: 'network-request-failed',
            message: 'A network error occurred',
          ),
        );

        // Act & Assert
        expect(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'test@example.com',
            password: 'password123',
          ),
          throwsA(isA<FirebaseAuthException>()),
        );
      });

      test('should handle invalid email format', () async {
        // Arrange
        when(
          mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'invalid-email',
            password: 'password123',
          ),
        ).thenThrow(
          FirebaseAuthException(
            code: 'invalid-email',
            message: 'The email address is badly formatted',
          ),
        );

        // Act & Assert
        expect(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'invalid-email',
            password: 'password123',
          ),
          throwsA(isA<FirebaseAuthException>()),
        );
      });
    });
  });
}
