import 'package:flutter/material.dart';

class AuthModeToggle extends StatelessWidget {
  const AuthModeToggle({
    super.key,
    required this.isLoginMode,
    required this.onToggle,
    required this.isLoading,
  });

  final bool isLoginMode;
  final VoidCallback onToggle;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox.shrink();
    }

    return TextButton(
      onPressed: onToggle,
      child: Text(
        isLoginMode
            ? 'Create new account'
            : 'I already have an account',
      ),
    );
  }
}