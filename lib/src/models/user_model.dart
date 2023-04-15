import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String uid;
  final String email;
  final String username;
  final List<String> followers;
  final List<String> following;
  final String? profilePic;
  final String? coverPic;
  final String? bio;
  final bool? isVerified;

  const UserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.followers,
    required this.following,
    this.profilePic,
    this.coverPic,
    this.bio,
    this.isVerified,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? username,
    List<String>? followers,
    List<String>? following,
    String? profilePic,
    String? coverPic,
    String? bio,
    bool? isVerified,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      username: username ?? this.username,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      profilePic: profilePic ?? this.profilePic,
      coverPic: coverPic ?? this.coverPic,
      bio: bio ?? this.bio,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({"email": email});
    result.addAll({"username": username});
    result.addAll({"followers": followers});
    result.addAll({"following": following});

    if (profilePic != null) {
      result.addAll({"profilePic": profilePic});
    }

    if (coverPic != null) {
      result.addAll({"coverPic": coverPic});
    }

    if (bio != null) {
      result.addAll({"bio": bio});
    }

    if (isVerified != null) {
      result.addAll({"isVerified": isVerified});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['\$id'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      followers: map['followers'] ? List<String>.from(map['followers']) : [],
      following: map['following'] ? List<String>.from(map['following']) : [],
      profilePic: map['profilePic'],
      coverPic: map['coverPic'],
      bio: map['bio'],
      isVerified: map['isVerified'] ?? false,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, username: $username, followers: $followers, following: $following, profilePic: $profilePic, coverPic: $coverPic, bio: $bio, isVerified: $isVerified)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.uid == uid &&
        other.email == email &&
        other.username == username &&
        listEquals(other.followers, followers) &&
        listEquals(other.following, following) &&
        other.profilePic == profilePic &&
        other.coverPic == coverPic &&
        other.bio == bio &&
        other.isVerified == isVerified;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        username.hashCode ^
        followers.hashCode ^
        following.hashCode ^
        profilePic.hashCode ^
        coverPic.hashCode ^
        bio.hashCode ^
        isVerified.hashCode;
  }
}
