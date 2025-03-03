// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/currency_conversions_model.dart';
import 'localization_controller.dart';
import 'logger_service.dart';

class CurrencyConversionService extends GetxService {
  final LoggerService logger = Get.find<LoggerService>();
  final LocalizationController localizationController =
      Get.find<LocalizationController>();

  bool conversionRatesFetchingDebouncingNew = false;
  Rx<CurrencyConversionsModel> conversionRates = CurrencyConversionsModel().obs;

  @override
  void onInit() {
    fetchConversionRates();
    super.onInit();
  }

  Future<void> fetchConversionRates() async {
    http.Response response = http.Response('', 999);
    final String userCurrencyCode =
        localizationController.selectedCurrency.value.code.toLowerCase();

    try {
      if (!conversionRatesFetchingDebouncingNew) {
        conversionRatesFetchingDebouncingNew = true;
        response = await http.get(
          Uri.parse(
            'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=chf,usd${!<String>[
              'usd',
              'chf',
            ].contains(userCurrencyCode) ? ',$userCurrencyCode' : ''}',
          ),
        );
        Future<void>.delayed(const Duration(milliseconds: 2000), () {
          conversionRatesFetchingDebouncingNew = false;
        });
      }
      if (response.statusCode == 200) {
        // ignore: always_specify_types
        final data = json.decode(response.body) as Map<String, dynamic>;
        conversionRates.value.BTCvsUSD =
            double.parse(data['bitcoin']!['usd']!.toString());
        conversionRates.value.BTCvsCHF =
            double.parse(data['bitcoin']!['chf']!.toString());
        conversionRates.value.BTCvsUSR =
            double.parse(data['bitcoin']![userCurrencyCode]!.toString());

        conversionRates.value.USDvsBTC = 1 / conversionRates.value.BTCvsUSD;
        conversionRates.value.CHFvsBTC = 1 / conversionRates.value.BTCvsCHF;
        conversionRates.value.USRvsBTC = 1 / conversionRates.value.BTCvsUSR;

        conversionRates.value.CHFvsUSD =
            conversionRates.value.BTCvsUSD / conversionRates.value.BTCvsCHF;
        conversionRates.value.USDvsCHF = 1 / conversionRates.value.CHFvsUSD;

        conversionRates.value.USRvsUSD =
            conversionRates.value.BTCvsUSD / conversionRates.value.BTCvsUSR;
        conversionRates.value.USDvsUSR = 1 / conversionRates.value.USRvsUSD;

        conversionRates.value.USRvsCHF =
            conversionRates.value.BTCvsCHF / conversionRates.value.BTCvsUSR;
        conversionRates.value.CHFvsUSR = 1 / conversionRates.value.USRvsCHF;
        conversionRates.value.printAllRates();
      } else if (response.statusCode == 429 || response.statusCode == 999) {
        return;
      } else {
        throw Exception(
          'Failed to load conversion rates with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load conversion rates: $e');
    }
  }

  int xToSatoshi(double amountInX) {
    try {
      return (amountInX * 100000000).toInt();
    } catch (e) {
      logger.log('Failed to convert x to satoshi: $e');
      return 0;
    }
  }

  double satoshiToX(double amountInSatoshi) {
    try {
      return amountInSatoshi / 100000000;
    } catch (e) {
      logger.log('Failed to convert satoshi to x: $e');
      return 0;
    }
  }
}
