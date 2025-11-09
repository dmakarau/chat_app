class UserProfile {
  final String id;
  final String username;
  final String email;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserProfile({
    required this.id,
    required this.username,
    required this.email,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfile.fromFirestore(Map<String, dynamic> data, String id) {
    return UserProfile(
      id: id,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      imageUrl: data['image_url'],
      createdAt: data['created_at']?.toDate(),
      updatedAt: data['updated_at']?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'username': username,
      'email': email,
      'image_url': imageUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  UserProfile copyWith({
    String? username,
    String? email,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id,
      username: username ?? this.username,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}