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

  Future<double> fetchConversionRateBTCUSD() async {
    // TODO Waiting for the user service to be implemented correctly
    /* final String targetCurrency =
        Get.find<UserStateService>().user.value.country; */

    try {
      final http.Response response = await http.get(
        Uri.parse(
          // TODO replace with the correct currency
          'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd',
        ),
      );
      if (response.statusCode == 200) {
        // ignore: always_specify_types
        final data = json.decode(response.body);
        // ignore: avoid_dynamic_calls
        return double.parse(data['bitcoin']['usd'].toString());
      } else if (response.statusCode == 429) {
        if (!snackBarDebouncing) {
          snackBarDebouncing = true;
          Get.snackbar(
            'Coingecko API rate limit reached',
            'This needs to be looked into before launching the app.',
            colorText: theme.snowfall,
            backgroundColor: theme.amberglow,
          );
          Future<void>.delayed(const Duration(milliseconds: 1000), () {
            snackBarDebouncing = false;
          });
        }
        throw Exception(
          'Failed to load conversion rate with status code: ${response.statusCode}',
        );
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
