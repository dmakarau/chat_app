/// App-wide constants
class AppConstants {
  // App Info
  static const String appName = 'Chat App';
  static const String appVersion = '1.0.0';

  // Validation
  static const int minPasswordLength = 6;
  static const int minUsernameLength = 3;
  static const int maxMessageLength = 500;

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 30.0;
  static const double mediumPadding = 20.0;

  static const double borderRadius = 8.0;
  static const double iconSize = 24.0;
  static const double largeIconSize = 120.0;

  // Container dimensions
  static const double iconContainerSize = 200.0;
  static const double borderWidth = 2.0;

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Error Messages
  static const String networkError =
      'Network connection error. Please try again.';
  static const String unknownError =
      'An unknown error occurred. Please try again.';
  static const String authError =
      'Authentication failed. Please check your credentials.';
}

/// API endpoints and configuration
class ApiConstants {
  static const String baseUrl = 'https://your-api-url.com/api';
  static const String authEndpoint = '/auth';
  static const String usersEndpoint = '/users';
  static const String messagesEndpoint = '/messages';

  // Request timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
