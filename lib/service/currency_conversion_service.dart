import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'localization_controller.dart';
import 'logger_service.dart';

class CurrencyConversionService extends GetxService {
  final LoggerService logger = Get.find<LoggerService>();
  final LocalizationController localizationController =
      Get.find<LocalizationController>();
  bool snackBarDebouncing = false;
  bool currencyConversionRateDebouncing = false;
  double conversionRateBTCUserCurrency = 0;
  double conversionRateFiatCHF = 0;

  Future<double> fetchFiatCHFRate() async {
    http.Response response = http.Response('', 999);

    if (localizationController.selectedCurrency['code']?.toLowerCase() ==
        'chf') {
      return 1;
    }
    try {
      if (!currencyConversionRateDebouncing) {
        currencyConversionRateDebouncing = true;
        response = await http.get(
          Uri.parse(
            'https://api.coingecko.com/api/v3/simple/price?ids=${localizationController.selectedCurrency['code'] ?? 'usd'}&vs_currencies=chf',
          ),
        );
        Future<void>.delayed(const Duration(milliseconds: 2000), () {
          currencyConversionRateDebouncing = false;
        });
      }
      if (response.statusCode == 999) {
        return conversionRateFiatCHF;
      }
      if (response.statusCode == 200) {
        // ignore: always_specify_types
        final data = json.decode(response.body);
        // ignore: avoid_dynamic_calls, join_return_with_assignment
        conversionRateFiatCHF = double.parse(
          // ignore: avoid_dynamic_calls
          data[localizationController.selectedCurrency['code'] ?? 'usd']['chf']
              .toString(),
        );

        return conversionRateFiatCHF;
      } else if (response.statusCode == 429) {
        return conversionRateFiatCHF;
      } else {
        throw Exception(
          'Failed to load conversion rate with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load conversion rate: $e');
    }
  }

  Future<double> fetchConversionRateBTCUserCurrency() async {
    http.Response response = http.Response('', 999);

    try {
      if (!currencyConversionRateDebouncing) {
        currencyConversionRateDebouncing = true;

        response = await http.get(
          Uri.parse(
            // TODO replace with the correct currency
            'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=${localizationController.selectedCurrency['code'] ?? 'usd'}',
          ),
        );

        Future<void>.delayed(const Duration(milliseconds: 2000), () {
          currencyConversionRateDebouncing = false;
        });
      }
      if (response.statusCode == 999) {
        return conversionRateBTCUserCurrency;
      }
      if (response.statusCode == 200) {
        // ignore: always_specify_types
        final data = json.decode(response.body);
        // ignore: avoid_dynamic_calls, join_return_with_assignment
        conversionRateBTCUserCurrency = double.parse(
          // ignore: avoid_dynamic_calls
          data['bitcoin'][localizationController.selectedCurrency['code']
                      ?.toLowerCase() ??
                  'usd']
              .toString(),
        );
        return conversionRateBTCUserCurrency;
      } else if (response.statusCode == 429) {
        return conversionRateBTCUserCurrency;
      } else {
        throw Exception(
          'Failed to load conversion rate with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load conversion rate: $e');
    }
  }

  Future<double> convertUserCurrencyToBitcoin(
    double amountInUserCurrency,
  ) async {
    try {
      final double rate = await fetchConversionRateBTCUserCurrency();

      return amountInUserCurrency * (1 / rate);
    } catch (e) {
      logger.log('Failed to convert user currency to bitcoin: $e');
      return 0.0;
    }
  }

  Future<double> convertBitcoinToUserCurrency(double amountInBitcoin) async {
    try {
      final double rate = await fetchConversionRateBTCUserCurrency();

      return amountInBitcoin * rate;
    } catch (e) {
      logger.log('Failed to convert bitcoin to user currency: $e');
      return 0.0;
    }
  }

  Future<double> convertSatoshiToUserCurrency(int amountInSatoshi) async {
    try {
      final double rate = await fetchConversionRateBTCUserCurrency();
      return amountInSatoshi * (rate / 100000000);
    } catch (e) {
      logger.log('Failed to convert satoshi to user currency: $e');
      return 0.0;
    }
  }
}
