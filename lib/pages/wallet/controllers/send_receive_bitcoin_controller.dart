import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_breez_liquid/flutter_breez_liquid.dart';
import 'package:get/get.dart';

import '../../../service/breez_service.dart';
import '../../../service/currency_conversion_service.dart';
import '../../../service/logger_service.dart';
import '../../../util/util.dart';

class SendReceiveBitcoinController extends GetxController {
  final LoggerService loggerService = Get.find<LoggerService>();
  BreezService breezService = Get.find<BreezService>();
  bool _isDebouncing = false;
  Timer _debounce = Timer(Duration.zero, () {});
  RxBool invoiceIsGenerated = false.obs;
  RxString createdInvoiceBolt11 = ''.obs;
  RxString invoiceAmountBTC = '0.0'.obs;
  RxString invoiceAmountUserCurrency = '0.0'.obs;
  RxString invoiceDescription = ''.obs;
  TextEditingController userInvoiceMessage = TextEditingController();
  RxString bolt11Invoice = ''.obs;
  final TextEditingController sendBTCInputBTC =
      TextEditingController(text: '0.0');
  RxString sendBTCInputCheck = '0.0'.obs;
  final TextEditingController sendBTCInputUserCurrency =
      TextEditingController(text: '0.0');
  final TextEditingController sendBTCInvoiceInput = TextEditingController();
  final RxString sendBTCPaymentError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    sendBTCInputBTC.addListener(
      () => _onPaymentChangedHandleDebounce(
        true,
      ),
    );
    sendBTCInputUserCurrency.addListener(
      () => _onPaymentChangedHandleDebounce(
        false,
      ),
    );
  }

  Future<void> createInvoice() async {
    if (Get.context != null) {
      showLoadingDialog(Get.context!);
    }

    createdInvoiceBolt11.value = await breezService.createInvoice(
      userInvoiceMessage.text,
      (double.parse(sendBTCInputBTC.text) * 100000000).round(),
    );

    if (Get.context != null) {
      hideLoadingDialog(Get.context!);
    }

    invoiceIsGenerated.value = true;
  }

  Future<void> getInvoiceAmount() async {
    /* try {
      sendBTCPaymentError.value = '';
      final LNInvoice invoice = await breezService.breezSDK.parseInvoice(
        sendBTCInvoiceInput.text,
      );
      bolt11Invoice.value = sendBTCInvoiceInput.text;
      invoiceDescription.value = invoice.description ?? '';

      double btcAmount = invoice.amountMsat! / 100000000000;

      if (btcAmount.toString().contains('.') &&
          btcAmount.toString().split('.')[1].length > 20) {
        btcAmount = double.parse(
          (invoice.amountMsat! / 100000000000).toStringAsFixed(20),
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
    } */
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

  void _onPaymentChangedHandleDebounce(
    bool isBTCInput,
  ) {
    sendBTCInputCheck.value = sendBTCInputBTC.text;
    if (_isDebouncing) return;

    if (_debounce.isActive) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () async {
      final String controllerText =
          isBTCInput ? sendBTCInputBTC.text : sendBTCInputUserCurrency.text;

      _isDebouncing = true;

      if (controllerText == '0' ||
          controllerText.isEmpty ||
          controllerText == '0.0') {
        if (isBTCInput) {
          sendBTCInputUserCurrency.text = '0.0';
        } else {
          sendBTCInputBTC.text = '0.0';
        }
      } else {
        final double otherValue = double.parse(controllerText);
        if (isBTCInput) {
          sendBTCInputUserCurrency.text =
              (await Get.find<CurrencyConversionService>()
                      .convertBitcoinToUserCurrency(otherValue))
                  .toString();
        } else {
          sendBTCInputBTC.text = (await Get.find<CurrencyConversionService>()
                  .convertUserCurrencyToBitcoin(otherValue))
              .toString();
        }
      }

      _isDebouncing = false;
    });
  }
}
