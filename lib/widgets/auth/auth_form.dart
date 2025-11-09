import 'dart:io';
import 'package:flutter/material.dart';
import '../user_image_picker.dart';
import '../../utils/validators.dart';
import '../../utils/app_spacing.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.isLoginMode,
    required this.onSubmit,
    required this.isLoading,
  });

  final bool isLoginMode;
  final Function({
    required String email,
    required String password,
    String? username,
    File? profileImage,
  }) onSubmit;
  final bool isLoading;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _enteredEmail = '';
  String _enteredPassword = '';
  String _enteredUsername = '';
  File? _selectedImage;

  void _handleSubmit() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    
    if (!widget.isLoginMode && _selectedImage == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a profile picture.')),
      );
      return;
    }

    _formKey.currentState!.save();

    widget.onSubmit(
      email: _enteredEmail,
      password: _enteredPassword,
      username: widget.isLoginMode ? null : _enteredUsername,
      profileImage: widget.isLoginMode ? null : _selectedImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUnfocus,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!widget.isLoginMode)
            UserImagePicker(
              onImagePicked: (File pickedImage) {
                _selectedImage = pickedImage;
              },
            ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email address',
            ),
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            validator: Validators.validateEmail,
            onSaved: (value) {
              _enteredEmail = value!;
            },
          ),
          if (!widget.isLoginMode)
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
              enableSuggestions: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a username.';
                }
                if (value.length < 3) {
                  return 'Username must be at least 3 characters long.';
                }
                return null;
              },
              onSaved: (value) {
                _enteredUsername = value!;
              },
            ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Password'),
            keyboardType: TextInputType.visiblePassword,
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            obscureText: true,
            validator: (value) => Validators.validatePassword(
              value,
              isSignUp: !widget.isLoginMode,
            ),
            onSaved: (value) {
              _enteredPassword = value!;
            },
          ),
          SizedBox(height: AppSpacing.mediumSpacing),
          if (widget.isLoading)
            const CircularProgressIndicator(),
          if (!widget.isLoading)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
              onPressed: _handleSubmit,
              child: Text(widget.isLoginMode ? 'Login' : 'Sign Up'),
            ),
        ],
      ),
    );
  }
}