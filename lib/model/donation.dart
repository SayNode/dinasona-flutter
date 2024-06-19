enum DonationField {
  food,
  water,
  clothes,
  firewood,
  babyhood,
  eggs,
  electricity,
  rice,
  corn,
  medicalSupplies,
  schoolSupplies,
  bread,
  milk;

  String get title {
    switch (this) {
      case DonationField.food:
        return 'Food';
      case DonationField.water:
        return 'Water';
      case DonationField.clothes:
        return 'Clothes';
      case DonationField.firewood:
        return 'Firewood';
      case DonationField.babyhood:
        return 'Babyhood';
      case DonationField.eggs:
        return 'Eggs';
      case DonationField.electricity:
        return 'Electricity';
      case DonationField.rice:
        return 'Rice';
      case DonationField.corn:
        return 'Corn';
      case DonationField.medicalSupplies:
        return 'Medical Supplies';
      case DonationField.schoolSupplies:
        return 'School Supplies';
      case DonationField.bread:
        return 'Bread';
      case DonationField.milk:
        return 'Milk';
    }
  }

  String get asset => 'assets/images/donation_fields/$name.png';
}

class Donation {
  Donation({
    required this.title,
    required this.description,
    required this.beneficiaryPhotoUrl,
    required this.beneficiaryName,
    required this.beneficiaryLocation,
    required this.amount,
    required this.donationFields,
    required this.photoUrls,
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      title: json['title'] as String,
      description: json['description'] as String,
      beneficiaryPhotoUrl: json['beneficiaryPhotoUrl'] as String,
      beneficiaryName: json['beneficiaryName'] as String,
      beneficiaryLocation: json['beneficiaryLocation'] as String,
      amount: json['amount'] as double,
      donationFields: (json['donationFields'] as List<dynamic>)
          .map((dynamic e) => DonationField.values[e as int])
          .toList(),
      photoUrls: (json['photoUrls'] as List<dynamic>)
          .map((dynamic e) => e as String)
          .toList(),
    );
  }
  final String title;
  final String description;
  final String beneficiaryPhotoUrl;
  final String beneficiaryName;
  final String beneficiaryLocation;
  final double amount;
  final List<DonationField> donationFields;
  final List<String> photoUrls;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'beneficiaryPhotoUrl': beneficiaryPhotoUrl,
      'beneficiaryName': beneficiaryName,
      'beneficiaryLocation': beneficiaryLocation,
      'amount': amount,
      'donationFields':
          donationFields.map((DonationField e) => e.index).toList(),
      'photoUrls': photoUrls,
    };
  }
}
