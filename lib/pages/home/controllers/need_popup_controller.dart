import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../model/need.dart';
import '../../../service/api_service.dart';
import '../../../service/logger_service.dart';
import '../../../util/constants.dart';
import '../../../util/popup_manager.dart';
import '../../wallet/controllers/send_payment_controller.dart';
import '../../wallet/send_bitcoin_page.dart';

class NeedPopupController extends GetxController {
  NeedPopupController({required this.need});
  final Need need;
  final APIService apiService = Get.find<APIService>();
  final LoggerService logger = Get.find<LoggerService>();
  final SendPaymentController sendPaymentController =
      Get.put(SendPaymentController());

  Future<void> donate(Need need) async {
    try {
      final http.Response createDonationResponse =
          await createDonationObject(need);

      if (createDonationResponse.statusCode != 201) {
        // ignore: avoid_dynamic_calls
        if (jsonDecode(createDonationResponse.body)['message'] ==
            'Donation already exists for this need') {
          await PopupManager.donationErrorPopup(
            'Donation already exists for this need'.tr,
          );
        } else {
          await PopupManager.donationErrorPopup(
            'Donation could not be created. Please try again later.'.tr,
          );
        }
      } else {
        await Get.to<void>(
          () => SendBitcoinPage(
            bolt11FromDonation: need.bolt11invoice,
            need: need,
          ),
        );
      }
    } catch (e) {
      await PopupManager.donationErrorPopup(
        'Donation could not be created. Please try again later.'.tr,
      );
    }
  }

  Future<http.Response> createDonationObject(Need need) async {
    final String url =
        Uri.https(Constants.apiDomain, '/donation/create/').toString();

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Bearer ${apiService.authenticationToken}',
          'Content-Type': 'application/json',
        },
        body: json.encode(<String, Object>{
          'need': need.id.toString(),
          'amount': need.amount, // This can be int or double
        }),
      );

      if (response.statusCode == 201) {
        logger.log(
          'Donation object for need with id ${need.id} created successfully',
        );
      } else {
        logger.log(
          'Failed to create donation object for need with id ${need.id}. Got status code: ${response.statusCode}, ${response.body}',
        );
      }
      return response;
    } catch (e) {
      logger.log(
        'Error creating donation object for need with id ${need.id}: $e',
      );
      throw Exception(
        'Error creating donation object for need with id ${need.id}: $e',
      );
    }
  }
}
