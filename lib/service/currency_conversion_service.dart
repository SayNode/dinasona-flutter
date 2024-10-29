import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../theme/theme.dart';
import 'logger_service.dart';
import 'theme_service.dart';

class CurrencyConversionService extends GetxService {
  final LoggerService logger = Get.find<LoggerService>();
  final CustomTheme theme = Get.put(ThemeService()).theme;
  bool snackBarDebouncing = false;
  bool currencyConversionRateDebouncing = false;
  double conversionRateBTCUSD = 0;
  // TODO change this
  double conversionRateFiatCHF = 0.87;

  Future<double> fetchFiatCHFRate() async {
    http.Response response = http.Response('', 999);

    try {
      if (!currencyConversionRateDebouncing) {
        currencyConversionRateDebouncing = true;
        response = await http.get(
          Uri.parse(
            // TODO replace with the correct currency
            'https://api.coingecko.com/api/v3/simple/price?ids=usd&vs_currencies=chf',
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
        conversionRateFiatCHF = double.parse(data['usd']['chf'].toString());
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

  Future<double> fetchConversionRateBTCUSD() async {
    http.Response response = http.Response('', 999);

    // TODO Waiting for the user service to be implemented correctly
    /* final String targetCurrency =
        Get.find<UserStateService>().user.value.country; */

    try {
      if (!currencyConversionRateDebouncing) {
        currencyConversionRateDebouncing = true;
        response = await http.get(
          Uri.parse(
            // TODO replace with the correct currency
            'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd',
          ),
        );
        Future<void>.delayed(const Duration(milliseconds: 2000), () {
          currencyConversionRateDebouncing = false;
        });
      }
      if (response.statusCode == 999) {
        return conversionRateBTCUSD;
      }
      if (response.statusCode == 200) {
        // ignore: always_specify_types
        final data = json.decode(response.body);
        // ignore: avoid_dynamic_calls, join_return_with_assignment
        conversionRateBTCUSD = double.parse(data['bitcoin']['usd'].toString());
        return conversionRateBTCUSD;
      } else if (response.statusCode == 429) {
        return conversionRateBTCUSD;
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
      final double rate = await fetchConversionRateBTCUSD();
      print('test rate: $rate');
      return amountInUserCurrency * (1 / rate);
    } catch (e) {
      logger.log('Failed to convert user currency to bitcoin: $e');
      return 0.0;
    }
  }

  Future<double> convertBitcoinToUserCurrency(double amountInBitcoin) async {
    try {
      final double rate = await fetchConversionRateBTCUSD();

      return amountInBitcoin * rate;
    } catch (e) {
      logger.log('Failed to convert bitcoin to user currency: $e');
      return 0.0;
    }
  }

  Future<double> convertSatoshiToUserCurrency(int amountInSatoshi) async {
    try {
      final double rate = await fetchConversionRateBTCUSD();
      return amountInSatoshi * (rate / 100000000);
    } catch (e) {
      logger.log('Failed to convert satoshi to user currency: $e');
      return 0.0;
    }
  }
}
