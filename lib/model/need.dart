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
  published,
  past;
}

class Need {
  Need({
    required this.title,
    required this.description,
    required this.beneficiary,
    required this.amount,
    required this.areasOfInterest,
    required this.images,
    required this.status,
    required this.bolt11invoice,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Need.fromJson(Map<String, dynamic> json) {
    final DateTime utcTime =
        DateTime.parse(json['created_at'] as String? ?? '');
    final DateTime utcTime2 =
        DateTime.parse(json['updated_at'] as String? ?? '');
    return Need(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      beneficiary: json['beneficiary'] != null
          ? Beneficiary.fromJson(json['beneficiary'] as Map<String, dynamic>)
          : Beneficiary.anonymous(),
      amount: double.parse(json['amount'] as String? ?? '0.0'),
      areasOfInterest: json['area_of_interest'] != null
          ? (json['area_of_interest'] as List<dynamic>)
              .map((dynamic e) => AreaOfInterest.values[(e as int) - 1])
              .toList()
          : <AreaOfInterest>[],
      images: (json['images'] is List &&
              (json['images'] as List<dynamic>).isNotEmpty)
          ? List<String>.from(json['images'] as List<dynamic>)
          : <String>[],
      status: json['status'] == null
          ? NeedStatus.draft
          : _statusFromString(json['status'] as String),
      bolt11invoice: json['bolt11Invoice'] as String? ?? '',
      id: json['id'] as int? ?? 0,
      createdAt: utcTime.toLocal(),
      updatedAt: utcTime2.toLocal(),
    );
  }

  static NeedStatus _statusFromString(String status) {
    switch (status) {
      case 'draft':
        return NeedStatus.draft;
      case 'published':
        return NeedStatus.ongoing;
      case 'closed':
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
  final List<String> images;
  final NeedStatus status;
  final String bolt11invoice;
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
}
