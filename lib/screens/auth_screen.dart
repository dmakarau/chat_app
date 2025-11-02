import 'package:flutter/material.dart';
import '../utils/validators.dart';
import '../utils/app_spacing.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoginScreen = true;
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
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.3),
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
                          ),
                          SizedBox(height: AppSpacing.medium.vertical),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                            ),
                            onPressed: () {},
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
