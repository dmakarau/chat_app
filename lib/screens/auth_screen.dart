import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/auth/auth_header.dart';
import '../widgets/auth/auth_form.dart';
import '../widgets/auth/auth_mode_toggle.dart';
import '../utils/app_spacing.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoginMode = true;
  bool _isAuthenticating = false;

  void _handleAuthSubmit({
    required String email,
    required String password,
    String? username,
    File? profileImage,
  }) async {
    try {
      setState(() {
        _isAuthenticating = true;
      });

      if (_isLoginMode) {
        await AuthService.signIn(email: email, password: password);
      } else {
        await UserService.registerUser(
          email: email,
          password: password,
          username: username!,
          profileImage: profileImage,
        );
      }
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        _showErrorMessage(error.message ?? 'Unknown error occurred.');
      }
    } catch (error) {
      if (mounted) {
        _showErrorMessage('An error occurred: ${error.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isAuthenticating = false;
        });
      }
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleAuthMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AuthHeader(),
              Card(
                margin: AppSpacing.cardMargin,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: AppSpacing.cardPadding,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AuthForm(
                          isLoginMode: _isLoginMode,
                          onSubmit: _handleAuthSubmit,
                          isLoading: _isAuthenticating,
                        ),
                        AuthModeToggle(
                          isLoginMode: _isLoginMode,
                          onToggle: _toggleAuthMode,
                          isLoading: _isAuthenticating,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
