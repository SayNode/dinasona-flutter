import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/currency_model.dart';

class CurrencyController extends GetxController {
  Rx<CurrencyModel> chosenCurrency = CurrencyModel(
    imageUrl: 'assets/images/switzerland.png',
    name: 'Swiss Frank',
    code: 'CHF',
  ).obs;

  final TextEditingController searchController = TextEditingController();

  final List<CurrencyModel> currency = <CurrencyModel>[
    CurrencyModel(
      imageUrl: 'assets/images/switzerland.png',
      name: 'Swiss Frank',
      code: 'CHF',
    ),
    CurrencyModel(
      imageUrl: 'assets/images/australia.png',
      name: 'Australian Dollar',
      code: 'AUD',
    ),
    CurrencyModel(
      imageUrl: 'assets/images/great_britain.png',
      name: 'British Pound',
      code: 'GBP',
    ),
    CurrencyModel(
      imageUrl: 'assets/images/canada.png',
      name: 'Canadian Dollar',
      code: 'CAD',
    ),
  ];
}
