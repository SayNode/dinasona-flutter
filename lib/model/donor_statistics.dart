// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DonorStatistics {
  //TODO: chek if the fields are correct or if some need to be double instead of int
  double totalAmountDonated;
  int totalCountriesDonatedTo;
  int totalBeneficiariesDonatedTo;
  DonorStatistics({
    required this.totalAmountDonated,
    required this.totalCountriesDonatedTo,
    required this.totalBeneficiariesDonatedTo,
  });

  DonorStatistics copyWith({
    double? totalAmountDonated,
    int? totalCountriesDonatedTo,
    int? totalBeneficiariesDonatedTo,
  }) {
    return DonorStatistics(
      totalAmountDonated: totalAmountDonated ?? this.totalAmountDonated,
      totalCountriesDonatedTo:
          totalCountriesDonatedTo ?? this.totalCountriesDonatedTo,
      totalBeneficiariesDonatedTo:
          totalBeneficiariesDonatedTo ?? this.totalBeneficiariesDonatedTo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total_amount_donated': totalAmountDonated,
      'total_beneficiaries_donated_to': totalCountriesDonatedTo,
      'total_countries_donated_to': totalBeneficiariesDonatedTo,
    };
  }

  factory DonorStatistics.fromMap(Map<String, dynamic> map) {
    return DonorStatistics(
      totalAmountDonated: map['total_amount_donated'] as double? ?? -1,
      totalCountriesDonatedTo:
          map['total_beneficiaries_donated_to'] as int? ?? -1,
      totalBeneficiariesDonatedTo:
          map['total_countries_donated_to'] as int? ?? -1,
    );
  }

  String toJson() => json.encode(toMap());

  factory DonorStatistics.fromJson(String source) =>
      DonorStatistics.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DonorStatistics(totalAmountDonated: $totalAmountDonated, totalCountriesDonatedTo: $totalCountriesDonatedTo, totalBeneficiariesDonatedTo: $totalBeneficiariesDonatedTo)';
}
