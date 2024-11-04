import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/breez_service.dart';
import '../../../service/currency_conversion_service.dart';
import '../../../service/logger_service.dart';
import '../../../util/util.dart';

class ReceivePaymentController extends GetxController {
  final LoggerService loggerService = Get.find<LoggerService>();
  BreezService breezService = Get.find<BreezService>();
  bool _isDebouncing = false;
  Timer _debounce = Timer(Duration.zero, () {});
  RxBool invoiceIsGenerated = false.obs;
  RxString createdInvoiceBolt11 = ''.obs;
  TextEditingController userInvoiceMessage = TextEditingController();
  final TextEditingController sendBTCInputBTC =
      TextEditingController(text: '0.0');
  RxString sendBTCUserCurrencyInputCheck = '0.0'.obs;
  final TextEditingController sendBTCInputUserCurrency =
      TextEditingController(text: '0.0');

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
      '${userInvoiceMessage.text} ::999',
      (double.parse(sendBTCInputBTC.text) * 100000000).round(),
    );

    if (Get.context != null) {
      hideLoadingDialog(Get.context!);
    }

    invoiceIsGenerated.value = true;
  }

  void _onPaymentChangedHandleDebounce(
    bool isBTCInput,
  ) {
    sendBTCUserCurrencyInputCheck.value = sendBTCInputUserCurrency.text;
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
