import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'storage_service.dart';
import 'auth_service.dart';

class UserService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Create user profile in Firestore
  static Future<void> createUserProfile({
    required String userId,
    required String username,
    required String email,
    required File? profileImage,
  }) async {
    try {
      String? imageUrl;

      // Upload profile image if provided
      if (profileImage != null) {
        imageUrl = await StorageService.uploadUserImage(
          imageFile: profileImage,
          userId: userId,
        );
      }

      // Create user document in Firestore
      await _firestore.collection('users').doc(userId).set({
        'username': username,
        'email': email,
        'image_url': imageUrl,
        'created_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }

  /// Get user profile from Firestore
  static Future<Map<String, dynamic>?> getUserProfile({
    required String userId,
  }) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      return doc.data();
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  /// Update user profile
  static Future<void> updateUserProfile({
    required String userId,
    String? username,
    File? newProfileImage,
  }) async {
    try {
      final Map<String, dynamic> updateData = {};

      if (username != null) {
        updateData['username'] = username;
      }

      if (newProfileImage != null) {
        final imageUrl = await StorageService.uploadUserImage(
          imageFile: newProfileImage,
          userId: userId,
        );
        updateData['image_url'] = imageUrl;
      }

      if (updateData.isNotEmpty) {
        updateData['updated_at'] = FieldValue.serverTimestamp();
        await _firestore.collection('users').doc(userId).update(updateData);
      }
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  /// Complete user registration process
  static Future<UserCredential> registerUser({
    required String email,
    required String password,
    required String username,
    required File? profileImage,
  }) async {
    try {
      // Create user account
      final userCredential = await AuthService.createAccount(
        email: email,
        password: password,
      );

      // Create user profile
      await createUserProfile(
        userId: userCredential.user!.uid,
        username: username,
        email: email,
        profileImage: profileImage,
      );

      return userCredential;
    } catch (e) {
      // If profile creation fails, we should clean up the auth account
      // In a production app, you might want more sophisticated error handling
      rethrow;
    }
  }

  /// Delete user profile (cleanup)
  static Future<void> deleteUserProfile({
    required String userId,
  }) async {
    try {
      // Delete profile image
      await StorageService.deleteUserImage(userId: userId);

      // Delete user document
      await _firestore.collection('users').doc(userId).delete();
    } catch (e) {
      throw Exception('Failed to delete user profile: $e');
    }
  }
}