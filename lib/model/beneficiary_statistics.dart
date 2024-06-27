// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BenbeficiaryStatistics {
  //TODO: chek if the fields are correct or if some need to be double instead of int
  int totalAmountDonated;
  int totalNeedsClosed;
  int totalPeopleDonated;
  BenbeficiaryStatistics({
    required this.totalAmountDonated,
    required this.totalNeedsClosed,
    required this.totalPeopleDonated,
  });

  BenbeficiaryStatistics copyWith({
    int? totalAmountDonated,
    int? totalNeedsClosed,
    int? totalPeopleDonated,
  }) {
    return BenbeficiaryStatistics(
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

  factory BenbeficiaryStatistics.fromMap(Map<String, dynamic> map) {
    return BenbeficiaryStatistics(
      totalAmountDonated: map['total_amount_donated'] as int? ?? -1,
      totalNeedsClosed: map['total_beneficiaries_donated_to'] as int? ?? -1,
      totalPeopleDonated: map['total_countries_donated_to'] as int? ?? -1,
    );
  }

  String toJson() => json.encode(toMap());

  factory BenbeficiaryStatistics.fromJson(String source) =>
      BenbeficiaryStatistics.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'BenbeficiaryStatistics(totalAmountDonated: $totalAmountDonated, totalNeedsClosed: $totalNeedsClosed, totalPeopleDonated: $totalPeopleDonated)';
}
