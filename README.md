# Chat App

A modern Flutter chat application with Firebase authentication, featuring a clean architecture and professional UI components.

## Technologies Used

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)

## Features

- **User Authentication**: Login and sign-up functionality with email validation
- **Form Validation**: Real-time form validation with user-friendly error messages
- **Modern UI**: Clean, responsive design following Material Design principles
- **Professional Architecture**: Well-organized code structure with utilities and constants

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── firebase_options.dart     # Firebase configuration
├── screens/
│   └── auth_screen.dart     # Authentication screen with login/signup
└── utils/
    ├── validators.dart      # Form validation utilities
    ├── constants.dart       # App-wide constants
    ├── app_spacing.dart     # Spacing design system
    ├── app_theme.dart       # Theme extensions
    └── helpers.dart         # Utility functions
```

## Architecture Highlights

### Design System
- **Consistent Spacing**: Centralized spacing constants for uniform UI
- **Semantic Design Tokens**: Professional spacing and sizing system
- **Theme Integration**: Custom theme extensions for maintainable styling

### Validation System
- **Progressive Validation**: Fields validate on unfocus for better UX
- **Context-Aware Rules**: Different validation rules for login vs signup
- **Clean Error Handling**: Inline error messages without intrusive popups

### Code Organization
- **Separation of Concerns**: Business logic separated from UI components
- **Reusable Utilities**: Centralized validation and helper functions
- **Scalable Structure**: Easy to extend with new features

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
- Must be a valid email format with proper domain structure
- Required for both login and signup

### Password Validation
- **Login Mode**: Any non-empty password accepted
- **Signup Mode**: Minimum 6 characters with at least one letter and one number

## UI Components

### Authentication Screen
- Circular app icon with modern styling
- Card-based form layout with clean spacing
- Dynamic toggle between login and signup modes
- Professional form validation with inline errors

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
- Non-intrusive error display under form fields
- Consistent error styling across the application

### Performance Considerations
- Efficient form validation with minimal rebuilds
- Proper widget disposal to prevent memory leaks
- Optimized imports and clean code structure

## Future Enhancements

- Chat messaging functionality
- User profile management
- Real-time message synchronization
- Push notifications
- File and image sharing

## Contributing

When contributing to this project, please maintain the established architecture patterns and code organization. Follow the existing validation and utility patterns for consistency.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
