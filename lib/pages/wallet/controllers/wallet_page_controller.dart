import 'dart:async';

import 'package:breez_sdk/bridge_generated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/breez_service.dart';
import '../../../service/currency_conversion_service.dart';
import '../../../service/logger_service.dart';
import '../../../util/util.dart';
import '../show_seed_phrase_page.dart';
import 'create_wallet_controller.dart';

class WalletPageController extends GetxController {
  BreezService breezService = Get.find<BreezService>();
  LoggerService loggerService = Get.find<LoggerService>();
  CurrencyConversionService currencyConversionService =
      Get.find<CurrencyConversionService>();

  RxDouble balanceInUSD = 0.0.obs;
  RxBool showWalletOptions = false.obs;
  RxList<Payment> transactions = <Payment>[].obs;
  RxList<double> transactionAmounts = <double>[].obs;
  RxString timeSinceLastTransaction = ''.obs;

  RxBool isWalletConnected = false.obs;

  final TextEditingController seedConfirmationInput1 = TextEditingController();
  final TextEditingController seedConfirmationInput2 = TextEditingController();
  final TextEditingController seedConfirmationInput3 = TextEditingController();

  void toggleShowWalletOptions() =>
      showWalletOptions.value = !showWalletOptions.value;

  Future<void> getTransactions() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final List<Payment> _transactions = await breezService.getPaymentHistory();
    // ignore: no_leading_underscores_for_local_identifiers
    final List<double> _transactionAmounts = <double>[];
    int lastTransactionTime = 0;
    transactions.clear();
    transactionAmounts.clear();

    for (final Payment transaction in _transactions) {
      if (lastTransactionTime < transaction.paymentTime) {
        lastTransactionTime = transaction.paymentTime;
      }
      _transactionAmounts.add(
        await currencyConversionService.convertSatoshiToUserCurrency(
          (transaction.amountMsat / 1000).round(),
        ),
      );
    }

    transactions.value = _transactions;
    transactionAmounts.value = _transactionAmounts;

    timeSinceLastTransaction.value = getTimePassedString(
      DateTime.fromMillisecondsSinceEpoch(
        lastTransactionTime * 1000,
      ),
    );
  }

  void resetWalletConnectionInputs() {
    seedConfirmationInput1.clear();
    seedConfirmationInput2.clear();
    seedConfirmationInput3.clear();
  }

  void deleteUserWallet() {
    clearWalletEnvironment();
  }

  void goToSeedPhraseConfirmation() {
    resetWalletConnectionInputs();
    Get.put(CreateWalletController()).seedPhrase.value =
        breezService.generateSeedPhrase();
    Get.to<void>(() => const ShowSeedPhrasePage());
  }

  Future<void> getBalanceInUSD() async {
    final int balanceInSatoshis =
        (await breezService.getBalanceInSatoshis() / 1000).round();

    // ignore: no_leading_underscores_for_local_identifiers
    final double _balanceInUSD = await currencyConversionService
        .convertSatoshiToUserCurrency(balanceInSatoshis);
    balanceInUSD.value = _balanceInUSD;
  }

  Future<void> clearWalletEnvironment() async {
    resetWalletConnectionInputs();
    try {
      await breezService.breezSDK.disconnect();
      // ignore: empty_catches
    } catch (e) {}
    try {
      await breezService.clearApplicationDocumentsDirectory();
      // ignore: empty_catches
    } catch (e) {}
    isWalletConnected.value = false;
  }
}
