import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/currency_model.dart';
import '../../../service/localization_controller.dart';

class CurrencyController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final LocalizationController localizationController =
      Get.find<LocalizationController>();
  RxList<CurrencyModel> currency = <CurrencyModel>[].obs;
  Rx<CurrencyModel> chosenCurrency = CurrencyModel(
    image: 'assets/images/switzerland.png',
    name: 'Swiss Frank',
    sign: 'CHF',
    code: 'CHF',
  ).obs;

  @override
  Future<void> onInit() async {
    chosenCurrency.value = localizationController.selectedCurrency.value;
    currency.addAll(localizationController.supportedCurrencies);
    super.onInit();
  }
}
