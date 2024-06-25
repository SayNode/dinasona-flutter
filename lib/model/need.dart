import 'beneficiary.dart';

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

enum NeedStatus {
  draft,
  ongoing,
  past,
}

class Need {
  Need({
    required this.title,
    required this.description,
    required this.beneficiary,
    required this.amount,
    required this.fields,
    required this.photoUrls,
    required this.status,
  });

  factory Need.fromJson(Map<String, dynamic> json) {
    return Need(
      title: json['title'] as String,
      description: json['description'] as String,
      beneficiary:
          Beneficiary.fromJson(json['beneficiary'] as Map<String, dynamic>),
      amount: json['amount'] as double,
      fields: (json['fields'] as List<dynamic>)
          .map((dynamic e) => NeedField.values[e as int])
          .toList(),
      photoUrls: (json['photoUrls'] as List<dynamic>)
          .map((dynamic e) => e as String)
          .toList(),
      status: NeedStatus.values[json['status'] as int],
    );
  }
  final String title;
  final String description;
  final Beneficiary beneficiary;
  final double amount;
  final List<NeedField> fields;
  final List<String> photoUrls;
  final NeedStatus status;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'beneficiary': beneficiary.toJson(),
      'amount': amount,
      'fields': fields.map((NeedField e) => e.index).toList(),
      'photoUrls': photoUrls,
      'status': status.index,
    };
  }
}
