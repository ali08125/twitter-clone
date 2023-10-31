import 'package:flutter/material.dart';

@immutable
class UserModel {
  final String name;
  final String email;
  final List<dynamic> followers;
  final List<dynamic> following;
  final String profilePic;
  final String bannerPic;
  final String uid;
  final String bio;
  final bool isTwitterBlue;

  const UserModel({
    required this.name,
    required this.email,
    required this.followers,
    required this.following,
    required this.profilePic,
    required this.bannerPic,
    required this.uid,
    required this.bio,
    required this.isTwitterBlue,
  });

  UserModel copyWith(
      {String? email,
      String? name,
      List<String>? followers,
      List<String>? following,
      String? profilePic,
      String? bannerPic,
      String? uid,
      String? bio,
      bool? isTwitterBlue}) {
    return UserModel(
        name: name ?? this.name,
        email: email ?? this.email,
        followers: followers ?? this.followers,
        following: following ?? this.following,
        profilePic: profilePic ?? this.profilePic,
        bannerPic: bannerPic ?? this.bannerPic,
        uid: uid ?? this.uid,
        bio: bio ?? this.bio,
        isTwitterBlue: isTwitterBlue ?? this.isTwitterBlue);
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'name': name});
    result.addAll({'followers': followers});
    result.addAll({'following': following});
    result.addAll({'profilePic': profilePic});
    result.addAll({'bannerPic': bannerPic});
    result.addAll({'bio': bio});
    result.addAll({'isTwitterBlue': isTwitterBlue});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        followers: map['followers'],
        following: map['following'],
        profilePic: map['profilePic'] ?? '',
        bannerPic: map['bannerPic'] ?? '',
        uid: map['uid'] ?? '',
        bio: map['bio'] ?? '',
        isTwitterBlue: map['isTwitterBlue'] ?? false);
  }
}
