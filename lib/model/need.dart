enum NeedField {
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
      case NeedField.food:
        return 'Food';
      case NeedField.water:
        return 'Water';
      case NeedField.clothes:
        return 'Clothes';
      case NeedField.firewood:
        return 'Firewood';
      case NeedField.babyhood:
        return 'Babyhood';
      case NeedField.eggs:
        return 'Eggs';
      case NeedField.electricity:
        return 'Electricity';
      case NeedField.rice:
        return 'Rice';
      case NeedField.corn:
        return 'Corn';
      case NeedField.medicalSupplies:
        return 'Medical Supplies';
      case NeedField.schoolSupplies:
        return 'School Supplies';
      case NeedField.bread:
        return 'Bread';
      case NeedField.milk:
        return 'Milk';
    }
  }

  String get asset => 'assets/images/need_fields/$name.png';
}

class Need {
  Need({
    required this.title,
    required this.description,
    required this.beneficiaryPhotoUrl,
    required this.beneficiaryName,
    required this.beneficiaryLocation,
    required this.amount,
    required this.fields,
    required this.photoUrls,
  });

  factory Need.fromJson(Map<String, dynamic> json) {
    return Need(
      title: json['title'] as String,
      description: json['description'] as String,
      beneficiaryPhotoUrl: json['beneficiaryPhotoUrl'] as String,
      beneficiaryName: json['beneficiaryName'] as String,
      beneficiaryLocation: json['beneficiaryLocation'] as String,
      amount: json['amount'] as double,
      fields: (json['fields'] as List<dynamic>)
          .map((dynamic e) => NeedField.values[e as int])
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
  final List<NeedField> fields;
  final List<String> photoUrls;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'beneficiaryPhotoUrl': beneficiaryPhotoUrl,
      'beneficiaryName': beneficiaryName,
      'beneficiaryLocation': beneficiaryLocation,
      'amount': amount,
      'fields': fields.map((NeedField e) => e.index).toList(),
      'photoUrls': photoUrls,
    };
  }
}
