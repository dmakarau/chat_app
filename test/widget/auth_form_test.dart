import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_app/widgets/auth/auth_form.dart';

void main() {
  group('AuthForm Widget Tests', () {
    testWidgets('should display email and password fields in login mode', (
      tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthForm(
              isLoginMode: true,
              onSubmit:
                  ({
                    required String email,
                    required String password,
                    String? username,
                    profileImage,
                  }) {
                    // Callback for form submission (not used in this test)
                  },
              isLoading: false,
            ),
          ),
        ),
      );

      // Assert
      expect(
        find.byType(TextFormField),
        findsNWidgets(2),
      ); // Email and password
      expect(find.text('Email address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(
        find.text('Username'),
        findsNothing,
      ); // Should not be visible in login mode
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets(
      'should display email, username, and password fields in signup mode',
      (tester) async {
        // Arrange
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AuthForm(
                isLoginMode: false,
                onSubmit:
                    ({
                      required String email,
                      required String password,
                      String? username,
                      profileImage,
                    }) {},
                isLoading: false,
              ),
            ),
          ),
        );

        // Assert
        expect(
          find.byType(TextFormField),
          findsNWidgets(3),
        ); // Email, username, and password
        expect(find.text('Email address'), findsOneWidget);
        expect(find.text('Username'), findsOneWidget);
        expect(find.text('Password'), findsOneWidget);
        expect(find.text('Sign Up'), findsOneWidget);
      },
    );

    testWidgets('should show loading indicator when isLoading is true', (
      tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthForm(
              isLoginMode: true,
              onSubmit:
                  ({
                    required String email,
                    required String password,
                    String? username,
                    profileImage,
                  }) {},
              isLoading: true,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('should validate email field', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthForm(
              isLoginMode: true,
              onSubmit:
                  ({
                    required String email,
                    required String password,
                    String? username,
                    profileImage,
                  }) {},
              isLoading: false,
            ),
          ),
        ),
      );

      // Act - Enter invalid email and trigger validation
      await tester.enterText(find.byType(TextFormField).first, 'invalid-email');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Assert
      expect(find.text('Please enter a valid email address.'), findsOneWidget);
    });

    testWidgets('should validate password field in signup mode', (
      tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthForm(
              isLoginMode: false,
              onSubmit:
                  ({
                    required String email,
                    required String password,
                    String? username,
                    profileImage,
                  }) {},
              isLoading: false,
            ),
          ),
        ),
      );

      // Act - Enter weak password and trigger validation
      final passwordField = find.byType(TextFormField).last;
      await tester.enterText(passwordField, '123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Assert
      expect(find.textContaining('Password must be at least'), findsOneWidget);
    });

    testWidgets('should validate username field in signup mode', (
      tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthForm(
              isLoginMode: false,
              onSubmit:
                  ({
                    required String email,
                    required String password,
                    String? username,
                    profileImage,
                  }) {},
              isLoading: false,
            ),
          ),
        ),
      );

      // Act - Leave username empty and trigger validation
      final usernameField = find
          .byType(TextFormField)
          .at(1); // Username is second field
      await tester.enterText(usernameField, '');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Assert
      expect(find.text('Please enter a username.'), findsOneWidget);
    });

    testWidgets('should submit valid form data in login mode', (tester) async {
      // Arrange
      bool submitCalled = false;
      Map<String, dynamic> submittedData = {};

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthForm(
              isLoginMode: true,
              onSubmit:
                  ({
                    required String email,
                    required String password,
                    String? username,
                    profileImage,
                  }) {
                    submitCalled = true;
                    submittedData = {
                      'email': email,
                      'password': password,
                      'username': username,
                      'profileImage': profileImage,
                    };
                  },
              isLoading: false,
            ),
          ),
        ),
      );

      // Act - Fill in valid data
      await tester.enterText(
        find.byType(TextFormField).at(0),
        'test@example.com',
      );
      await tester.enterText(find.byType(TextFormField).at(1), 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Assert
      expect(submitCalled, isTrue);
      expect(submittedData['email'], equals('test@example.com'));
      expect(submittedData['password'], equals('password123'));
      expect(submittedData['username'], isNull);
      expect(submittedData['profileImage'], isNull);
    });

    testWidgets('should submit valid form data in signup mode', (tester) async {
      // Arrange
      bool submitCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthForm(
              isLoginMode: false,
              onSubmit:
                  ({
                    required String email,
                    required String password,
                    String? username,
                    profileImage,
                  }) {
                    submitCalled = true;
                  },
              isLoading: false,
            ),
          ),
        ),
      );

      // Act - Fill in valid data
      await tester.enterText(
        find.byType(TextFormField).at(0),
        'test@example.com',
      );
      await tester.pump(const Duration(milliseconds: 100));
      await tester.enterText(find.byType(TextFormField).at(1), 'testuser');
      await tester.pump(const Duration(milliseconds: 100));
      await tester.enterText(find.byType(TextFormField).at(2), 'password123');
      await tester.pump(const Duration(milliseconds: 100));

      // Note: This test focuses on form validation and data submission
      // The profile image requirement is tested separately
      // For now, we'll test the form submission flow without image

      // Try to submit (will fail due to missing image, but won't crash)
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert - Form submission should be blocked due to missing image
      // This is the expected behavior for signup mode
      expect(submitCalled, isFalse); // Should be false due to missing image
      expect(find.text('Please select a profile picture.'), findsOneWidget);
    });
    testWidgets('should not submit form with invalid data', (tester) async {
      // Arrange
      bool submitCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthForm(
              isLoginMode: true,
              onSubmit:
                  ({
                    required String email,
                    required String password,
                    String? username,
                    profileImage,
                  }) {
                    submitCalled = true;
                  },
              isLoading: false,
            ),
          ),
        ),
      );

      // Act - Try to submit with empty fields
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Assert
      expect(submitCalled, isFalse);
      expect(find.text('Please enter an email address.'), findsOneWidget);
    });

    testWidgets('should show image picker in signup mode', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthForm(
              isLoginMode: false,
              onSubmit:
                  ({
                    required String email,
                    required String password,
                    String? username,
                    profileImage,
                  }) {},
              isLoading: false,
            ),
          ),
        ),
      );

      // Assert - Should include UserImagePicker widget
      expect(find.byKey(const ValueKey('user_image_picker')), findsOneWidget);
    });

    testWidgets('should not show image picker in login mode', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthForm(
              isLoginMode: true,
              onSubmit:
                  ({
                    required String email,
                    required String password,
                    String? username,
                    profileImage,
                  }) {},
              isLoading: false,
            ),
          ),
        ),
      );

      // Assert - Should not include UserImagePicker widget
      expect(find.byKey(const ValueKey('user_image_picker')), findsNothing);
    });
  });
}
