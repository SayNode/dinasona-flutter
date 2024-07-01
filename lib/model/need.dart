import 'beneficiary.dart';

enum AreaOfInterest {
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
      case AreaOfInterest.food:
        return 'Food';
      case AreaOfInterest.water:
        return 'Water';
      case AreaOfInterest.clothes:
        return 'Clothes';
      case AreaOfInterest.firewood:
        return 'Firewood';
      case AreaOfInterest.babyhood:
        return 'Babyhood';
      case AreaOfInterest.eggs:
        return 'Eggs';
      case AreaOfInterest.electricity:
        return 'Electricity';
      case AreaOfInterest.rice:
        return 'Rice';
      case AreaOfInterest.corn:
        return 'Corn';
      case AreaOfInterest.medicalSupplies:
        return 'Medical Supplies';
      case AreaOfInterest.schoolSupplies:
        return 'School Supplies';
      case AreaOfInterest.bread:
        return 'Bread';
      case AreaOfInterest.milk:
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
    required this.areasOfInterest,
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
      areasOfInterest: (json['area_of_interest'] as List<dynamic>)
          .map((dynamic e) => AreaOfInterest.values[(e as int) - 1])
          .toList(),
      photoUrls: (json['images'] as List<dynamic>)
          .map((dynamic e) => e as String)
          .toList(),
      status: _statusFromString(json['status'] as String),
    );
  }

  static NeedStatus _statusFromString(String status) {
    switch (status) {
      case 'draft':
        return NeedStatus.draft;
      case 'ongoing':
        return NeedStatus.ongoing;
      case 'past':
        return NeedStatus.past;
      default:
        return NeedStatus.draft;
    }
  }

  final String title;
  final String description;
  final Beneficiary beneficiary;
  final double amount;
  final List<AreaOfInterest> areasOfInterest;
  final List<String> photoUrls;
  final NeedStatus status;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'beneficiary': beneficiary.toJson(),
      'amount': amount,
      'area_of_interest':
          areasOfInterest.map((AreaOfInterest e) => e.index + 1).toList(),
      'images': photoUrls,
      'status': status.index,
    };
  }
}
