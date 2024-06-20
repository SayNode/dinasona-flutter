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
      name: json['name'] as String,
      location: json['location'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String,
      dateOfBirth: DateTime.fromMillisecondsSinceEpoch(
        json['dateOfBirth'] as int,
      ),
      gender: Gender.values[json['gender'] as int],
      bio: json['bio'] as String,
    );
  }
  final String name;
  final String location;
  final String email;
  final String photoUrl;
  final DateTime dateOfBirth;
  final Gender gender;
  final String bio;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'location': location,
      'email': email,
      'photoUrl': photoUrl,
      'dateOfBirth': dateOfBirth.millisecondsSinceEpoch,
      'gender': gender.index,
      'bio': bio,
    };
  }
}
