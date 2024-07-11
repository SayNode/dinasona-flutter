import 'package:intl/intl.dart';

enum Gender {
  male,
  female,
  preferNotToSay;

  String get title {
    switch (this) {
      case male:
        return 'Male';
      case female:
        return 'Female';
      case preferNotToSay:
        return 'Prefer not to say';
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
  });

  factory Beneficiary.fromJson(Map<String, dynamic> json) {
    return Beneficiary(
      name: json['name'] as String? ?? 'Anonymous',
      location: json['location'] as String? ?? 'Location hidden',
      email: json['email'] as String? ?? 'Email hidden',
      photoUrl: json['photo_url'] as String? ?? '',
      dateOfBirth: json['date_of_birth'] == null
          ? null
          : format.parse(
              json['date_of_birth'] as String,
            ),
      gender: Gender.preferNotToSay,
      /* json['gender'] == null
          ? Gender.preferNotToSay
          : Gender.values[json['gender'] as int],*/
      bio: json['bio'] as String? ?? 'Empty bio',
    );
  }

  static DateFormat format = DateFormat('yyyy-MM-dd');
  final String name;
  final String location;
  final String email;
  final String photoUrl;
  final DateTime? dateOfBirth;
  final Gender gender;
  final String bio;
}
