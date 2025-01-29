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
  bool currencyConversionRateDebouncingSecond = false;
  double conversionRateBTCUserCurrency = 0;
  double conversionRateUserTargetCurrency = 0;
  double conversionRateBTCvsUSD = 0;

  @override
  void onInit() {
    fetchUserTargetCurrencyRate('usd');
    super.onInit();
  }

  // Coingecko provides the most allowed requests per minute for the free plan
  // only works with crypto though - workaround:
  // 1. get the conversion rate from the user currency to bitcoin
  // 2. get the conversion rate from bitcoin to the target currency
  // 3. divide the conversion rate from the user currency to bitcoin by the
  //    conversion rate from bitcoin to the target currency
  Future<double> fetchUserTargetCurrencyRate(String targetCurrencyCode) async {
    http.Response response = http.Response('', 999);
    final String targetCurrencyCodeClean = targetCurrencyCode.toLowerCase();
    final String userCurrencyCodeClean =
        localizationController.selectedCurrency.value.code.toLowerCase();

    if (userCurrencyCodeClean == targetCurrencyCodeClean) {
      return 1;
    }

    try {
      if (!currencyConversionRateDebouncing) {
        currencyConversionRateDebouncing = true;
        response = await http.get(
          Uri.parse(
            'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=$userCurrencyCodeClean,$targetCurrencyCodeClean',
          ),
        );
        Future<void>.delayed(const Duration(milliseconds: 2000), () {
          currencyConversionRateDebouncing = false;
        });
      }
      if (response.statusCode == 999) {
        return conversionRateUserTargetCurrency;
      }
      if (response.statusCode == 200) {
        // ignore: always_specify_types
        final data = json.decode(response.body);

        final double userCurrencyToBTC = double.parse(
          // ignore: avoid_dynamic_calls
          data['bitcoin'][userCurrencyCodeClean].toString(),
        );
        final double targetCurrencyToBTC = double.parse(
          // ignore: avoid_dynamic_calls
          data['bitcoin'][targetCurrencyCodeClean].toString(),
        );

        return conversionRateUserTargetCurrency = double.parse(
          (userCurrencyToBTC / targetCurrencyToBTC).toStringAsFixed(4),
        );
      } else if (response.statusCode == 429) {
        return conversionRateUserTargetCurrency;
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
            'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=${localizationController.selectedCurrency.value.code.toLowerCase()}',
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
          double.parse(
            // ignore: avoid_dynamic_calls
            data['bitcoin'][localizationController.selectedCurrency.value.code
                    .toLowerCase()]
                .toString(),
          ).toStringAsFixed(4),
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

  Future<double> fetchConversionRateBTCvsUSD() async {
    http.Response response = http.Response('', 999);

    try {
      if (!currencyConversionRateDebouncingSecond) {
        currencyConversionRateDebouncingSecond = true;

        response = await http.get(
          Uri.parse(
            // TODO replace with the correct currency
            'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd',
          ),
        );

        Future<void>.delayed(const Duration(milliseconds: 2000), () {
          currencyConversionRateDebouncingSecond = false;
        });
      }
      if (response.statusCode == 999) {
        return conversionRateBTCvsUSD;
      }
      if (response.statusCode == 200) {
        // ignore: always_specify_types
        final data = json.decode(response.body);
        // ignore: avoid_dynamic_calls, join_return_with_assignment
        conversionRateBTCvsUSD = double.parse(
          double.parse(
            // ignore: avoid_dynamic_calls
            data['bitcoin']['usd'].toString(),
          ).toStringAsFixed(4),
        );
        return conversionRateBTCvsUSD;
      } else if (response.statusCode == 429) {
        return conversionRateBTCvsUSD;
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

      return double.parse(
        (amountInUserCurrency * (1 / rate)).toStringAsFixed(4),
      );
    } catch (e) {
      logger.log('Failed to convert user currency to bitcoin: $e');
      return 0.0;
    }
  }

  Future<double> convertBitcoinToUserCurrency(double amountInBitcoin) async {
    try {
      final double rate = await fetchConversionRateBTCUserCurrency();

      return double.parse((amountInBitcoin * rate).toStringAsFixed(4));
    } catch (e) {
      logger.log('Failed to convert bitcoin to user currency: $e');
      return 0.0;
    }
  }

  Future<double> convertSatoshiToUserCurrency(int amountInSatoshi) async {
    try {
      final double rate = await fetchConversionRateBTCUserCurrency();
      return double.parse(
        (amountInSatoshi * (rate / 100000000)).toStringAsFixed(4),
      );
    } catch (e) {
      logger.log('Failed to convert satoshi to user currency: $e');
      return 0.0;
    }
  }
}
