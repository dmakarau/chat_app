# Chat App

A fully functional real-time chat application built with Flutter and Firebase, demonstrating clean architecture principles and modern development practices. This project showcases user authentication, profile management, file uploads, and real-time messaging in a production-ready mobile application.

## Technologies Used

![Flutter](https://img.shields.io/badge/Flutter-54C5F8?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-2BB7F6?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-DD2C00?style=for-the-badge&logo=firebase&logoColor=white)
![Firebase Auth](https://img.shields.io/badge/Firebase_Auth-FF6F00?style=for-the-badge&logo=firebase&logoColor=white)
![Firebase Storage](https://img.shields.io/badge/Firebase_Storage-FF8F00?style=for-the-badge&logo=firebase&logoColor=white)
![Cloud Firestore](https://img.shields.io/badge/Cloud_Firestore-FFA000?style=for-the-badge&logo=firebase&logoColor=white)
![Material Design](https://img.shields.io/badge/Material_Design-6200EA?style=for-the-badge&logo=material-design&logoColor=white)

## Features

### Authentication & User Management
- Complete user registration and login system with Firebase Authentication
- User profile creation with custom usernames and profile pictures
- Secure image upload and storage using Firebase Storage
- Form validation with context-aware rules for login and signup modes
- Automatic session management and secure logout functionality

### Real-Time Chat
- Live messaging with instant message delivery
- User-friendly chat interface with message bubbles
- Message composition with send functionality
- Real-time message synchronization across devices
- User identification with profile pictures and usernames in messages

### Technical Excellence
- Clean architecture with separated service, model, and UI layers
- Comprehensive error handling with user-friendly feedback
- Professional Material Design 3 interface
- Cross-platform compatibility for iOS and Android
- Secure configuration management with sensitive data excluded from version control

## Project Architecture

This application follows clean architecture principles with clear separation between different layers of the application.

### Service Layer
The business logic is encapsulated in dedicated service classes that handle specific responsibilities:

- **AuthService**: Manages user authentication, login, logout, and authentication state
- **UserService**: Handles user profile operations including registration and profile management
- **StorageService**: Manages file uploads and downloads for profile pictures
- **ChatService**: Handles all chat-related operations including sending and retrieving messages

### Model Layer
Data structures with proper typing and serialization methods:

- **UserProfile**: User account information with Firestore integration
- **ChatMessage**: Message data structure for real-time chat functionality

### UI Layer
Clean presentation layer focused solely on user interface:

- **Screens**: Authentication, chat, and splash screens with proper state management
- **Widgets**: Reusable UI components including message bubbles, image pickers, and form controls

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── firebase_options.dart     # Firebase configuration (excluded from git)
├── models/                   # Data models
│   ├── user_profile.dart    # User account data structure
│   └── chat_message.dart    # Chat message data structure
├── services/                 # Business logic layer
│   ├── auth_service.dart    # Authentication operations
│   ├── user_service.dart    # User profile management
│   ├── storage_service.dart # File upload/download operations
│   └── chat_service.dart    # Chat messaging operations
├── screens/                  # Application screens
│   ├── auth_screen.dart     # Login and registration interface
│   ├── chat_screen.dart     # Main chat interface
│   └── splash_screen.dart   # Loading screen
├── widgets/                  # Reusable UI components
│   ├── user_image_picker.dart  # Profile picture selection
│   ├── composer.dart           # Message input widget
│   ├── messages_list.dart      # Chat messages display
│   └── message_bubble.dart     # Individual message bubbles
└── utils/                    # Utility functions and constants
    ├── validators.dart      # Form validation logic
    ├── app_spacing.dart     # Design system spacing
    ├── app_theme.dart       # Theme customizations
    ├── constants.dart       # Application constants
    └── helpers.dart         # Helper functions
```

## Technical Highlights

### Clean Architecture Implementation
The application demonstrates professional software development practices through proper separation of concerns. Business logic is isolated in service classes, data models handle serialization, and UI components focus purely on presentation. This approach makes the code maintainable, testable, and scalable.

### Real-Time Capabilities
Messages appear instantly across all connected devices using Cloud Firestore's real-time listeners. The chat interface updates automatically when new messages are sent, providing a seamless conversational experience.

### Security Best Practices
All sensitive Firebase configuration files are excluded from version control. User authentication is handled securely through Firebase Auth, and file uploads are managed with proper access controls through Firebase Storage.

### User Experience Design
The interface follows Material Design 3 guidelines with thoughtful user interactions. Form validation provides immediate feedback, loading states keep users informed, and error messages are helpful rather than technical.

## Dependencies

- **flutter**: Flutter SDK framework
- **firebase_core**: ^4.2.1 - Firebase SDK initialization
- **firebase_auth**: ^6.1.1 - User authentication services
- **firebase_storage**: ^13.0.4 - File storage for profile pictures
- **cloud_firestore**: ^6.1.0 - Real-time NoSQL database
- **image_picker**: ^1.2.0 - Image selection from device gallery

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- iOS Simulator or Android Emulator
- Firebase project with Authentication, Cloud Firestore, and Storage enabled

### Installation

1. **Clone and Install Dependencies**
   ```bash
   git clone https://github.com/dmakarau/chat_app.git
   cd chat_app
   flutter pub get
   ```

2. **Firebase Configuration**
   
   This application requires Firebase services that must be configured individually for security reasons.

   **Create Firebase Project**
   - Visit [Firebase Console](https://console.firebase.google.com/)
   - Create a new project
   - Enable Authentication with Email/Password sign-in method
   - Create a Cloud Firestore database in test mode
   - Enable Firebase Storage

   **Configure Platforms**
   
   Install Firebase CLI and FlutterFire CLI:
   ```bash
   npm install -g firebase-tools
   dart pub global activate flutterfire_cli
   ```

   Configure your project:
   ```bash
   firebase login
   flutterfire configure
   ```

   Select your Firebase project and the platforms you want to support (Android and iOS recommended).

3. **Run the Application**
   ```bash
   flutter run
   ```

### Quick Setup for Experienced Developers
```bash
git clone https://github.com/dmakarau/chat_app.git
cd chat_app
flutter pub get
flutterfire configure  # Select your Firebase project
flutter run
```

## Application Features

### Authentication System
Users can create new accounts or log into existing ones with email and password authentication. The registration process includes setting a custom username and uploading a profile picture. Form validation provides real-time feedback, with different rules for login versus signup modes.

### User Profiles
Each user has a complete profile with a username, email, and optional profile picture. Profile images are uploaded to Firebase Storage and optimized automatically. User data is stored securely in Cloud Firestore for fast access across the application.

### Real-Time Chat
The main chat interface displays messages in real-time with user identification through profile pictures and usernames. Messages are stored in Cloud Firestore and synchronized instantly across all connected devices. The chat interface includes message composition with a clean, intuitive design.

### Security and Privacy
All sensitive configuration data is excluded from the repository. User authentication is managed through Firebase Auth with secure session handling. File uploads are processed through Firebase Storage with appropriate access controls.

## Development Notes

### Architecture Patterns
The codebase follows clean architecture principles with clear separation between data, business logic, and presentation layers. Services handle all Firebase operations, models define data structures, and UI components focus on user interface concerns.

### Error Handling
Comprehensive error handling provides meaningful feedback to users while logging technical details for debugging. Network errors, authentication failures, and validation issues are handled gracefully with user-friendly messages.

### Performance Considerations
The application uses efficient widgets and proper disposal patterns to prevent memory leaks. Database queries are optimized for real-time performance, and images are automatically optimized during upload.

## Testing & Quality Assurance

This project includes **enterprise-grade testing infrastructure** with comprehensive test coverage and automated CI/CD pipeline.

### Test Coverage
- **44 Unit Tests**: Complete business logic testing with mock-based isolation
- **12+ Widget Tests**: UI component testing with interaction validation  
- **Integration Testing**: End-to-end workflow verification
- **Coverage Reporting**: Automated coverage analysis with HTML reports

### CI/CD Pipeline
- **GitHub Actions**: 3-stage development-focused pipeline
- **Quality Gates**: Code analysis, formatting checks, and comprehensive testing
- **Test Validation**: Automated unit and widget test execution with coverage
- **Security Scanning**: Dependency audits and code security analysis
- **Documentation**: Automated API documentation generation and deployment

### Testing Tools
- **Mockito**: Professional mock generation for isolated unit testing
- **Flutter Test**: Widget testing framework with interaction simulation
- **Build Runner**: Automated code generation for mocks and builders
- **Coverage Reports**: LCOV and HTML coverage reporting

### Running Tests
```bash
# Run all tests with coverage
flutter test --coverage

# Run comprehensive test suite with build verification
./run_tests.sh --build

# Generate mocks (when adding new tests)
dart run build_runner build
```

📊 **For detailed testing documentation, see [TESTING_SUMMARY.md](TESTING_SUMMARY.md)**

This testing setup rivals what you'd find at major tech companies and ensures reliable, maintainable code at scale.

## Troubleshooting

### Common Setup Issues
- **Firebase configuration errors**: Ensure you have run `flutterfire configure` and selected the correct project
- **Build failures on iOS**: This project requires iOS 15.0 or later due to Firebase dependencies
- **Android build issues**: Ensure you have the latest version of Android Studio and build tools

### Runtime Issues
- **Authentication not working**: Verify that Email/Password authentication is enabled in your Firebase project
- **Messages not appearing**: Check that Cloud Firestore is properly configured and security rules allow read/write access
- **Image upload failures**: Ensure Firebase Storage is enabled and configured correctly

## Contributing

This project demonstrates clean architecture patterns and modern Flutter development practices. When contributing, please maintain the established separation of concerns between services, models, and UI components. Follow the existing patterns for error handling, validation, and state management.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
