import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Gender {
  anonymous,
  male,
  female;

  String get title {
    switch (this) {
      case anonymous:
        return 'Prefer not to say';
      case male:
        return 'Male';
      case female:
        return 'Female';
    }
  }

  IconData get icon {
    switch (this) {
      case anonymous:
        return Icons.sentiment_satisfied_alt;
      case male:
        return Icons.male;
      case female:
        return Icons.female;
    }
  }
}

class Beneficiary {
  Beneficiary({
    required this.name,
    required this.location,
    required this.email,
    required this.photoUrl,
    required this.dateOfBirth,
    required this.gender,
    required this.bio,
    required this.userId,
    required this.country,
  });

  factory Beneficiary.fromJson(Map<String, dynamic> json) {
    return Beneficiary(
      name: json['name'] as String? ?? 'Anonymous',
      location: json['city'] as String? ?? '',
      email: json['email'] as String? ?? 'Email hidden',
      photoUrl: json['photo_url'] as String? ?? '',
      dateOfBirth: json['date_of_birth'] == null
          ? null
          : format.parse(
              json['date_of_birth'] as String,
            ),
      gender: (json['gender'] == null)
          ? Gender.anonymous
          : (json['gender'] as int == 0 ? Gender.male : Gender.female),
      bio: json['bio'] as String? ??
          json['description'] as String? ??
          'Empty bio',
      userId: json['id'] as int? ?? -1,
      country: json['country'] as String? ?? '',
    );
  }
  factory Beneficiary.anonymous() {
    return Beneficiary(
      name: 'Anonymous',
      location: 'Location hidden',
      email: 'Email hidden',
      photoUrl: '',
      dateOfBirth: null,
      gender: Gender.anonymous,
      bio: 'Empty bio',
      userId: -1,
      country: '',
    );
  }

  static DateFormat format = DateFormat('yyyy-MM-dd');
  String name;
  String location;
  String email;
  String? photoUrl;
  DateTime? dateOfBirth;
  Gender gender;
  String bio;
  int userId;
  String country;
}
