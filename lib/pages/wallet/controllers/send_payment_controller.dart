import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_breez_liquid/flutter_breez_liquid.dart';
import 'package:get/get.dart';

import '../../../service/breez_service.dart';
import '../../../service/currency_conversion_service.dart';
import '../../../service/logger_service.dart';
import '../../../util/util.dart';

class SendPaymentController extends GetxController {
  final LoggerService loggerService = Get.find<LoggerService>();
  BreezService breezService = Get.find<BreezService>();

  RxString invoiceAmountBTC = '0.0'.obs;
  RxString invoiceAmountUserCurrency = '0.0'.obs;
  RxString invoiceDescription = ''.obs;
  RxString bolt11Invoice = ''.obs;
  final TextEditingController sendBTCInvoiceInput = TextEditingController();
  final RxString sendBTCPaymentError = ''.obs;

  Future<void> getInvoiceAmount() async {
    try {
      sendBTCPaymentError.value = '';
      final LNInvoice invoice = await breezService.parseInvoice(
        sendBTCInvoiceInput.text,
      );
      bolt11Invoice.value = sendBTCInvoiceInput.text;
      invoiceDescription.value = invoice.description ?? '';

      double btcAmount = invoice.amountMsat!.toInt() / 100000000000;

      if (btcAmount.toString().contains('.') &&
          btcAmount.toString().split('.')[1].length > 20) {
        btcAmount = double.parse(
          (invoice.amountMsat!.toInt() / 100000000000).toStringAsFixed(20),
        );
      }

      invoiceAmountBTC.value = btcAmount.toString();
      invoiceAmountUserCurrency.value =
          (await Get.find<CurrencyConversionService>()
                  .convertBitcoinToUserCurrency(
        btcAmount,
      ))
              .toString();
    } catch (e) {
      if (sendBTCInvoiceInput.text.length > 2) {
        sendBTCPaymentError.value = 'Invalid invoice'.tr;
      }

      invoiceAmountBTC.value = '0.0';
      invoiceAmountUserCurrency.value = '0.0';
      invoiceDescription.value = '';
      loggerService.log('Error getting invoice amount: $e');
    }
  }

  Future<void> sendBitcoin() async {
    final dynamic response;

    if (Get.context != null) {
      showLoadingDialog(Get.context!);
    }

    try {
      response = await breezService.sendPayment(
        bolt11Invoice.value,
      );
    } catch (e) {
      sendBTCPaymentError.value = 'Insufficient outgoing balance'.tr;
      loggerService.log('Error sending payment: $e');
      if (Get.context != null) {
        hideLoadingDialog(Get.context!);
      }
      return;
    }

    if (response is SendPaymentResponse) {
      // TODO might add a status indicator here in the future
    } else {
      sendBTCPaymentError.value = response.toString();
    }

    if (Get.context != null) {
      hideLoadingDialog(Get.context!);
    }
  }
}
