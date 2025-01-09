import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/liquid_limits.dart';
import '../../../service/breez_service.dart';
import '../../../service/currency_conversion_service.dart';
import '../../../service/localization_controller.dart';
import '../../../service/logger_service.dart';
import '../../../util/util.dart';
import '../../help_payment_page/help_payment_page.dart';

class ReceivePaymentController extends GetxController {
  final LoggerService loggerService = Get.find<LoggerService>();
  BreezService breezService = Get.find<BreezService>();
  bool _isDebouncing = false;
  Timer _debounce = Timer(Duration.zero, () {});
  RxBool invoiceIsGenerated = false.obs;
  RxString createdInvoiceBolt11 = ''.obs;
  TextEditingController userInvoiceMessage = TextEditingController();
  final TextEditingController receiveBTCInputBTC =
      TextEditingController(text: '0.0');
  RxString receiveBTCUserCurrencyInputCheck = '0.0'.obs;
  final TextEditingController receiveBTCInputUserCurrency =
      TextEditingController(text: '0.0');
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    receiveBTCInputBTC.addListener(
      () => _onPaymentChangedHandleDebounce(
        true,
      ),
    );
    receiveBTCInputUserCurrency.addListener(
      () => _onPaymentChangedHandleDebounce(
        false,
      ),
    );
  }

  Future<void> createInvoice({int needId = 999}) async {
    if (Get.context != null) {
      showLoadingDialog(Get.context!);
    }

    try {
      createdInvoiceBolt11.value = await breezService.createInvoice(
        '${userInvoiceMessage.text} ::$needId',
        (double.parse(receiveBTCInputBTC.text) * 100000000).round(),
      );
      invoiceIsGenerated.value = true;
    } catch (e) {
      if (e.toString().contains('amountOutOfRange')) {
        error.value = 'Amount is over or below outgoing balance limit';
      }
      invoiceIsGenerated.value = false;
    }

    if (Get.context != null) {
      hideLoadingDialog(Get.context!);
    }
  }

  void _onPaymentChangedHandleDebounce(
    bool isBTCInput,
  ) {
    receiveBTCUserCurrencyInputCheck.value = receiveBTCInputUserCurrency.text;
    if (_isDebouncing) {
      checkLiquidLimits();
      return;
    }

    if (_debounce.isActive) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () async {
      final String controllerText = isBTCInput
          ? receiveBTCInputBTC.text
          : receiveBTCInputUserCurrency.text;

      _isDebouncing = true;
      if (controllerText == '0' ||
          controllerText.isEmpty ||
          controllerText == '0.0') {
        if (isBTCInput) {
          receiveBTCInputUserCurrency.text = '0.0';
        } else {
          receiveBTCInputBTC.text = '0.0';
        }
      } else {
        final double otherValue = double.parse(controllerText);
        if (isBTCInput) {
          receiveBTCInputUserCurrency.text =
              (await Get.find<CurrencyConversionService>()
                      .convertBitcoinToUserCurrency(otherValue))
                  .toString();
        } else {
          receiveBTCInputBTC.text = (await Get.find<CurrencyConversionService>()
                  .convertUserCurrencyToBitcoin(otherValue))
              .toString();
        }

        checkLiquidLimits();
      }

      _isDebouncing = false;
    });
  }

  void checkLiquidLimits() {
    if (receiveBTCInputUserCurrency.text == '0' ||
        receiveBTCInputUserCurrency.text.isEmpty ||
        receiveBTCInputUserCurrency.text == '0.0') {
      return;
    }
    final LiquidLimitUserCurrency receivingLimitsInSatoshi =
        breezService.liquidSendReceiveLimitsInUserCurrency.receive;
    final double receiveUserCurrencyAmount =
        double.parse(receiveBTCInputUserCurrency.text) + 0.01;

    if (receiveUserCurrencyAmount < receivingLimitsInSatoshi.minUserCurrency ||
        receiveUserCurrencyAmount > receivingLimitsInSatoshi.maxUserCurrency) {
      error.value =
          'Amount must be between ${Get.find<LocalizationController>().selectedCurrency['sign'] ?? r'$'} ${receivingLimitsInSatoshi.minUserCurrency.toStringAsFixed(2)} and ${Get.find<LocalizationController>().selectedCurrency['sign'] ?? r'$'} ${receivingLimitsInSatoshi.maxUserCurrency.toStringAsFixed(2)}';
    } else {
      error.value = '';
    }
  }

  void helpPage() {
    Get.to<void>(HelpPaymentPage.new);
  }
}
