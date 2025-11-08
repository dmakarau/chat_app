# Chat App

A Flutter chat application with Firebase authentication and real-time capabilities, showcasing professional development practices and clean architecture patterns.

## Technologies Used

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Firebase Auth](https://img.shields.io/badge/Firebase_Auth-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Material Design](https://img.shields.io/badge/Material_Design-757575?style=for-the-badge&logo=material-design&logoColor=white)

## Current Features

- **Firebase Integration**: Complete Firebase setup with secure configuration management
- **User Authentication**: Full login, signup, and logout functionality with Firebase Auth
- **Authentication Flow Management**: Automatic navigation based on user authentication state
- **Screen Management**: Multi-screen architecture with splash, authentication, and chat screens
- **Session Management**: Secure user logout with automatic return to authentication screen
- **Form Validation**: Progressive validation with context-aware rules (different for login vs signup)
- **Professional UI**: Material Design 3 with custom color scheme and responsive layouts
- **Clean Architecture**: Organized code structure with separation of concerns
- **Error Handling**: Comprehensive Firebase error handling with user-friendly messages
- **Security Best Practices**: Sensitive configuration files excluded from version control

## Implementation Status

### Completed
- Firebase project setup and initialization
- Complete user authentication system (login, registration, and logout)
- Authentication flow management with automatic screen navigation
- Multi-screen architecture with proper state management
- Authentication screen with login/signup mode toggle
- Splash screen for loading states
- Chat screen foundation with logout functionality
- User session management with secure logout
- Form validation with progressive error display
- Professional UI components and spacing system
- Secure configuration file management
- Cross-platform build configuration (Android, iOS, macOS, Windows)
- Firebase Authentication error handling

### In Development
- Chat messaging functionality
- Real-time message synchronization
- User profile management

## Project Structure

```
lib/
├── main.dart                 # Application entry point with authentication flow
├── firebase_options.dart     # Firebase configuration
├── screens/
│   ├── auth_screen.dart     # Authentication screen with login/signup
│   ├── chat_screen.dart     # Main chat interface
│   └── splash_screen.dart   # Loading screen for app initialization
└── utils/
    ├── validators.dart      # Form validation utilities
    ├── constants.dart       # App-wide constants
    ├── app_spacing.dart     # Spacing design system
    ├── app_theme.dart       # Theme extensions
    └── helpers.dart         # Utility functions
```

## Architecture Highlights

### Authentication System
- **Progressive Validation**: Fields validate on unfocus for better user experience
- **Context-Aware Rules**: Different validation requirements for login vs signup modes
- **Firebase Integration**: Complete user authentication with login, registration, and logout
- **Form State Management**: Clean form validation with GlobalKey and state control
- **Error Handling**: Comprehensive Firebase exception handling with user-friendly messages
- **Authentication Flow**: Automatic navigation between screens based on user state
- **Session Management**: Persistent authentication state using Firebase Auth stream
- **Secure Logout**: One-click logout functionality with automatic return to authentication screen

### UI/UX Design
- **Material Design 3**: Modern Flutter theming with custom color schemes
- **Responsive Layout**: Adaptive design with proper spacing and typography
- **Professional Spacing**: Centralized design system with semantic spacing tokens
- **Clean Error Display**: Inline validation messages without disruptive popups

### Code Organization
- **Separation of Concerns**: Business logic separated from UI components
- **Reusable Utilities**: Centralized validation, constants, and helper functions
- **Scalable Architecture**: Easy to extend with new features and maintain
- **Security-First**: Sensitive configuration properly excluded from version control
- **Multi-Screen Architecture**: Clean separation of authentication, loading, and main app screens
- **State-Driven Navigation**: Authentication state automatically controls screen flow

## Dependencies

- **firebase_core**: ^4.2.0 - Firebase SDK initialization
- **firebase_auth**: ^6.1.1 - User authentication services
- **flutter**: SDK - Flutter framework

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- iOS Simulator or Android Emulator
- Firebase project with Authentication enabled

### Installation

#### Quick Start (For Experienced Developers)
```bash
# Clone and setup
git clone https://github.com/dmakarau/chat_app.git
cd chat_app
flutter pub get

# Configure Firebase (requires Firebase CLI)
flutterfire configure

# Run
flutter run
```

#### Detailed Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/dmakarau/chat_app.git
   cd chat_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. **Configure Firebase** (Critical Setup):
   
   This app requires Firebase configuration files that are not included in the repository for security reasons. Follow these steps to set up Firebase:

   #### A. Create Firebase Project
   1. Go to [Firebase Console](https://console.firebase.google.com/)
   2. Create a new project or use existing one
   3. Enable Authentication with Email/Password provider

   #### B. Add Android App
   1. Click "Add app" → "Android" 
   2. Package name: `com.example.chat_app` (or your chosen package)
   3. Download `google-services.json`
   4. Place it in: `android/app/google-services.json`

   #### C. Add iOS App  
   1. Click "Add app" → "iOS"
   2. Bundle ID: `com.example.chatApp` (or your chosen bundle)
   3. Download `GoogleService-Info.plist`
   4. Place it in: `ios/Runner/GoogleService-Info.plist`

   #### D. Generate Flutter Configuration
   1. Install Firebase CLI: `npm install -g firebase-tools`
   2. Install FlutterFire CLI: `dart pub global activate flutterfire_cli`
   3. Login to Firebase: `firebase login`
   4. Configure FlutterFire: `flutterfire configure`
   5. Select your Firebase project
   6. Select platforms (Android, iOS)
   7. This generates: `lib/firebase_options.dart` and `firebase.json`

   **Note**: These configuration files contain sensitive API keys and are excluded from version control for security.

4. Run the application:
   ```bash
   flutter run
   ```

## Security Notes

### Excluded Files
The following files contain sensitive Firebase configuration and are not included in the repository:

```
lib/firebase_options.dart       # Contains API keys and app IDs
firebase.json                   # Contains project configuration
android/app/google-services.json    # Android Firebase config
ios/Runner/GoogleService-Info.plist # iOS Firebase config
```

**Important**: Never commit these files to version control. They are automatically excluded via `.gitignore`.

### Team Setup
If you're working with a team:
1. Share Firebase project access through Firebase Console
2. Each developer must run `flutterfire configure` individually
3. Use the same Firebase project for consistent authentication

## Troubleshooting

### Firebase Setup Issues
- **Error**: "No Firebase options found" → Run `flutterfire configure`
- **Error**: "google-services.json not found" → Download from Firebase Console
- **Error**: "Unable to find bundle identifier" → Check iOS bundle ID matches Firebase config
- **Error**: "Firebase project not found" → Verify you're logged into correct Firebase account

### iOS Build Issues
- **Error**: "Minimum deployment target" → iOS 15.0+ required (see iOS Setup Notes below)
- **Error**: "Pod install failed" → Run `cd ios && pod install --repo-update`

## iOS Setup Notes

This project requires iOS 15.0 or later due to Firebase dependencies. The following files have been configured:

- `ios/Podfile`: Platform target set to iOS 15.0
- `ios/Flutter/AppFrameworkInfo.plist`: MinimumOSVersion updated to 15.0

## Validation Rules

### Email Validation
- Required field with comprehensive format validation
- Uses industry-standard regex pattern for email verification
- Applied consistently across both login and signup modes

### Password Validation
- **Login Mode**: Accepts any non-empty password for existing account authentication
- **Signup Mode**: Enforces security requirements (minimum 6 characters, must contain letters and numbers)
- Progressive validation provides immediate feedback during account creation

## UI Components

### Authentication Screen
- Circular app icon with modern styling
- Card-based form layout with clean spacing
- Dynamic toggle between login and signup modes
- Professional form validation with inline errors
- Complete Firebase authentication integration for both user flows

### Chat Screen
- Clean app bar with application title
- Logout button with exit icon for easy access
- One-click logout functionality with immediate session termination
- Automatic navigation back to authentication upon logout
- Foundation layout ready for chat messages

### Form Controls
- Material Design text fields with proper keyboard types
- Secure password input with obscured text
- Themed buttons with consistent styling
- Responsive layout for different screen sizes

## Development Notes

### State Management
- StatefulWidget for form state and mode switching
- Form keys for validation control
- Clean separation of form logic and UI

### Error Handling
- Field-level validation with specific error messages
- Firebase exception handling with meaningful user feedback
- Non-intrusive error display under form fields
- Consistent error styling across the application
- Authentication error recovery with clear user guidance

### Performance Considerations
- Efficient form validation with minimal rebuilds
- Proper widget disposal to prevent memory leaks
- Optimized imports and clean code structure

## Current Functionality

### Authentication Flow
- Complete authentication interface with seamless mode switching between login and signup
- Firebase user authentication supporting both existing and new users
- Comprehensive form validation with real-time error feedback
- Professional error handling with descriptive Firebase exception messages
- Secure session management through Firebase Auth
- Automatic navigation to chat screen upon successful authentication
- One-click logout functionality accessible from the chat screen
- Automatic return to authentication screen after logout
- Splash screen during app initialization and authentication state checking

### Application Architecture
- Stream-based authentication state management using Firebase Auth
- Clean separation between authentication, loading, and main application screens
- Automatic screen navigation based on user authentication status
- Persistent user sessions with proper state restoration

### Technical Implementation
- Firebase SDK integration across all supported platforms
- Secure configuration management excluding sensitive data from version control
- Professional Flutter development patterns with proper state management
- Cross-platform compatibility with iOS 15.0+ requirement for Firebase features
- Robust exception handling for common authentication scenarios
- Clean code architecture ready for chat functionality implementation

## Planned Features

- Complete login functionality implementation
- Chat messaging interface with real-time synchronization
- User profile management and settings
- Push notifications for new messages
- File and image sharing capabilities

## Contributing

When contributing to this project, please maintain the established architecture patterns and code organization. Follow the existing validation and utility patterns for consistency.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
