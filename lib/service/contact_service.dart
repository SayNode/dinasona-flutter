import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../util/constants.dart';
import 'api_service.dart';
import 'logger_service.dart';

class ContactService extends GetxService {
  final APIService apiService = Get.find<APIService>();
  final LoggerService logger = Get.find<LoggerService>();

  Future<bool> submitMessage(String message) async {
    final String url =
        Uri.https(Constants.apiDomain, '/contact_support/new/').toString();

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Bearer ${apiService.authenticationToken}',
        },
        body: <String, dynamic>{
          'message': message,
        },
      );

      if (response.statusCode == 201) {
        logger.log('Contact us message sent successfully');
        return true;
      } else {
        logger.log(
          'Failed to send contact us message with StatusCode: ${response.statusCode}, ${response.body}',
        );
        return false;
      }
    } catch (e) {
      logger.log('Error while sending contact us message: $e');
      return false;
    }
  }
}
