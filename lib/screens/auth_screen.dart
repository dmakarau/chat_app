import 'package:flutter/material.dart';
import '../utils/validators.dart';
import '../utils/app_spacing.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoginScreen = true;
  String _enteredEmail = '';
  String _enteredPassword = '';

  void _handleSubmit() {
    // Force validation of all fields, including password
    final isValid = _formKey.currentState!.validate();
    
    if (isValid) {
      _formKey.currentState!.save();
      print('Email: $_enteredEmail, Password: $_enteredPassword');
    }
    // If validation fails, error messages will automatically show under fields
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
              Container(
                margin: AppSpacing.iconContainerMargin,
                width: AppSpacing.iconContainerSize,
                height: AppSpacing.iconContainerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.3),
                    width: AppSpacing.containerBorderWidth,
                  ),
                ),
                child: Icon(
                  Icons.forum,
                  size: AppSpacing.iconSize,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Card(
                margin: AppSpacing.cardMargin,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: AppSpacing.cardPadding,
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: Validators.validateEmail,
                            onSaved: (value ) {
                              _enteredEmail = value!;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password'),
                            keyboardType: TextInputType.visiblePassword,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            obscureText: true,
                            validator: (value) => Validators.validatePassword(
                              value, 
                              isSignUp: !_isLoginScreen,
                            ),
                             onSaved: (value ) {
                              _enteredPassword = value!;
                            },
                          ),
                          SizedBox(height: AppSpacing.mediumSpacing),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                            ),
                            onPressed: _handleSubmit,
                            child: Text(_isLoginScreen ? 'Login' : 'Sign Up'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLoginScreen = !_isLoginScreen;
                              });
                            },
                            child: Text(
                              _isLoginScreen
                                  ? 'Create new account'
                                  : 'I already have an account',
                            ),
                          ),
                        ],
                      ),
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
