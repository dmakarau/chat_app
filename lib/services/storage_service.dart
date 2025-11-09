import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload user profile image
  static Future<String> uploadUserImage({
    required File imageFile,
    required String userId,
  }) async {
    try {
      // Create reference to user images location
      final storageRef = _storage
          .ref()
          .child('user_images')
          .child('$userId.jpg');

      // Upload file
      await storageRef.putFile(imageFile);

      // Get download URL
      final imageUrl = await storageRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  /// Delete user profile image
  static Future<void> deleteUserImage({required String userId}) async {
    try {
      final storageRef = _storage
          .ref()
          .child('user_images')
          .child('$userId.jpg');

      await storageRef.delete();
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }
}
