// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

import '../service/logger_service.dart';

class CurrencyConversionsModel {
  double BTCvsUSD = 0;
  double BTCvsCHF = 0;
  double BTCvsUSR = 0;

  double USDvsBTC = 0;
  double CHFvsBTC = 0;
  double USRvsBTC = 0;

  double CHFvsUSD = 0;
  double USDvsCHF = 0;

  double USRvsUSD = 0;
  double USDvsUSR = 0;

  double USRvsCHF = 0;
  double CHFvsUSR = 0;

  void printAllRates() {
    final Map<String, double> fields = <String, double>{
      'BTC vs USD': BTCvsUSD,
      'BTC vs CHF': BTCvsCHF,
      'BTC vs USR': BTCvsUSR,
      'USD vs BTC': USDvsBTC,
      'CHF vs BTC': CHFvsBTC,
      'USR vs BTC': USRvsBTC,
      'CHF vs USD': CHFvsUSD,
      'USD vs CHF': USDvsCHF,
      'USR vs USD': USRvsUSD,
      'USD vs USR': USDvsUSR,
      'USR vs CHF': USRvsCHF,
      'CHF vs USR': CHFvsUSR,
    };

    final LoggerService loggerService = Get.find<LoggerService>()
      ..log('Currency Conversion Rates:');
    // ignore: cascade_invocations
    fields.forEach((String key, double value) {
      loggerService.log('$key: ${value.toStringAsFixed(6)}');
    });
  }
}
