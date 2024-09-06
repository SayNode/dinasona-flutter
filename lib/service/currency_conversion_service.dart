import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CurrencyConversionService extends GetxService {
  Future<int> fetchConversionRateBTCUSD() async {
    // Waiting for the user service to be implemented correctly
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
        return data['bitcoin']['usd'] as int;
      } else {
        throw Exception(
          'Failed to load conversion rate with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load conversion rate: $e');
    }
  }

  Future<double> convertSatoshisToUSD(int satoshis) async {
    try {
      final int rate = await fetchConversionRateBTCUSD();
      return satoshis * (rate / 100000000);
    } catch (e) {
      return 0.0;
    }
  }
}
