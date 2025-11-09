/// Validation utility functions for forms
class Validators {
  /// Validates email addresses
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address.';
    }

    // Comprehensive email validation regex
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }

    return null;
  }

  /// Validates password strength
  static String? validatePassword(String? value, {bool isSignUp = false}) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password.';
    }

    if (isSignUp) {
      if (value.length < 6) {
        return 'Password must be at least 6 characters long.';
      }

      // Check for at least one letter and one number
      if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)').hasMatch(value)) {
        return 'Password must contain at least one letter and one number.';
      }
    }

    return null;
  }

  /// Validates required fields
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName.';
    }
    return null;
  }

  /// Validates username
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username.';
    }

    if (value.length < 3) {
      return 'Username must be at least 3 characters long.';
    }

    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores.';
    }

    return null;
  }
}
