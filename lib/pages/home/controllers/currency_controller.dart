import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/currency_model.dart';
import '../../../util/mock_data.dart';

class CurrencyController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  RxList<CurrencyModel> currency = <CurrencyModel>[].obs;
  Rx<CurrencyModel> chosenCurrency = CurrencyModel(
    imageUrl: 'assets/images/switzerland.png',
    name: 'Swiss Frank',
    code: 'CHF',
  ).obs;

  @override
  Future<void> onInit() async {
    currency.addAll(MockData.currency);
    super.onInit();
  }
}
