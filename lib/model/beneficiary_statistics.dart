// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BeneficiaryStatistics {
  //TODO: chek if the fields are correct or if some need to be double instead of int
  int totalAmountDonated;
  int totalNeedsClosed;
  int totalPeopleDonated;
  BeneficiaryStatistics({
    required this.totalAmountDonated,
    required this.totalNeedsClosed,
    required this.totalPeopleDonated,
  });

  BeneficiaryStatistics copyWith({
    int? totalAmountDonated,
    int? totalNeedsClosed,
    int? totalPeopleDonated,
  }) {
    return BeneficiaryStatistics(
      totalAmountDonated: totalAmountDonated ?? this.totalAmountDonated,
      totalNeedsClosed: totalNeedsClosed ?? this.totalNeedsClosed,
      totalPeopleDonated: totalPeopleDonated ?? this.totalPeopleDonated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total_amount_donated': totalAmountDonated,
      'total_needs_closed': totalNeedsClosed,
      'total_people_donated': totalPeopleDonated,
    };
  }

  factory BeneficiaryStatistics.fromMap(Map<String, dynamic> map) {
    return BeneficiaryStatistics(
      totalAmountDonated: map['total_amount_donated'] as int? ?? -1,
      totalNeedsClosed: map['total_beneficiaries_donated_to'] as int? ?? -1,
      totalPeopleDonated: map['total_countries_donated_to'] as int? ?? -1,
    );
  }

  String toJson() => json.encode(toMap());

  factory BeneficiaryStatistics.fromJson(String source) =>
      BeneficiaryStatistics.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'BenbeficiaryStatistics(totalAmountDonated: $totalAmountDonated, totalNeedsClosed: $totalNeedsClosed, totalPeopleDonated: $totalPeopleDonated)';
}
