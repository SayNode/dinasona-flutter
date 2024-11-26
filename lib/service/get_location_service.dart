import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<Map<String, String>> getLocationFromIP() async {
  try {
    // Step 1: Get the public IP address
    final http.Response ipResponse = await http.get(Uri.parse('https://api.ipify.org?format=json'));
    if (ipResponse.statusCode != 200) {
      throw Exception('Failed to get IP address');
    }
    final Map<String, dynamic> ipJson = jsonDecode(ipResponse.body) as Map<String, dynamic>;
    final String ip = ipJson['ip'] as String;

    // Step 2: Get location information from the IP
    final http.Response locationResponse = await http.get(Uri.parse('http://ip-api.com/json/$ip'));
    if (locationResponse.statusCode != 200) {
      throw Exception('Failed to get location from IP');
    }
    final Map<String, dynamic> locationData = jsonDecode(locationResponse.body) as Map<String, dynamic>;

    // Step 3: Extract country and city
    final String country = locationData['country'] as String;
    final String city = locationData['city'] as String;

    return <String, String>{'country': country, 'city': city};
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return <String, String>{};
  }
}
