// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DonorStatistics {
  int totalAmountDonated;
  int totalCountriesDonatedTo;
  int totalBeneficiariesDonatedTo;
  DonorStatistics({
    required this.totalAmountDonated,
    required this.totalCountriesDonatedTo,
    required this.totalBeneficiariesDonatedTo,
  });

  DonorStatistics copyWith({
    int? totalAmountDonated,
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
      totalAmountDonated: map['total_amount_donated'] as int,
      totalCountriesDonatedTo: map['total_beneficiaries_donated_to'] as int,
      totalBeneficiariesDonatedTo: map['total_countries_donated_to'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DonorStatistics.fromJson(String source) =>
      DonorStatistics.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DonorStatistics(totalAmountDonated: $totalAmountDonated, totalCountriesDonatedTo: $totalCountriesDonatedTo, totalBeneficiariesDonatedTo: $totalBeneficiariesDonatedTo)';
}
