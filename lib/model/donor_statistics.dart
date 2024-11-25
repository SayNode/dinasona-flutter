// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DonorStatistics {
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
      'total_countries_donated_to': totalCountriesDonatedTo,
      'total_beneficiaries_donated_to': totalBeneficiariesDonatedTo,
    };
  }

  factory DonorStatistics.fromMap(Map<String, dynamic> map) {
    return DonorStatistics(
      // Safely parse total_amount_donated as double
      totalAmountDonated: map['total_amount_donated'] != null
          ? double.tryParse(map['total_amount_donated'].toString()) ?? 0.0
          : 0.0,
      // Correctly map total_countries_donated_to
      totalCountriesDonatedTo: map['total_countries_donated_to'] as int? ?? 0,
      // Correctly map total_beneficiaries_donated_to
      totalBeneficiariesDonatedTo:
          map['total_beneficiaries_donated_to'] as int? ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DonorStatistics.fromJson(String source) =>
      DonorStatistics.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DonorStatistics(totalAmountDonated: $totalAmountDonated, totalCountriesDonatedTo: $totalCountriesDonatedTo, totalBeneficiariesDonatedTo: $totalBeneficiariesDonatedTo)';
}
